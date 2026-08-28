#!/usr/bin/env python3
"""Mini-Simulator fuer die von uns benutzten Datapack-Befehle.
Bildet Scoreboard, execute-Bedingungen, Funktionsaufrufe, Trigger und Schedule
nach und spielt die Raetsel-Kette als Fake-Spieler durch. Kein Minecraft, aber
er validiert die LOGIK (State-Wechsel, Trigger-Freischaltung, Win/Lose)."""
import os, glob, re, sys

ROOT = "/home/user/aisukurimu/minecraft/countdown-atoll/datapack/data/aisu_escape/function"

functions = {}
for path in glob.glob(os.path.join(ROOT, "**", "*.mcfunction"), recursive=True):
    rel = os.path.relpath(path, ROOT)[:-len(".mcfunction")].replace(os.sep, "/")
    name = "aisu_escape:" + rel
    lines = []
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        s = ln.strip()
        if not s or s.startswith("#"):
            continue
        lines.append(s)
    functions[name] = lines

# ---- Welt-Zustand ----
scores = {}            # (holder, obj) -> int
objectives = {}        # name -> type
enabled = set()        # (player, obj) trigger freigeschaltet
players = []            # Spielernamen
bossbar = {}
schedule = {}          # funcname -> faellig-Tick (nicht praezise genutzt)
sim_holding_ken = [False]
RET = ("RETURN",)
DEPTH = [0]

def is_player_holder(h): return not h.startswith("#")

def parse_range(r):
    if ".." in r:
        a, b = r.split("..", 1)
        lo = float("-inf") if a == "" else int(a)
        hi = float("inf") if b == "" else int(b)
        return lo, hi
    v = int(r); return v, v

def score_matches(holder, obj, rng):
    v = scores.get((holder, obj))
    if v is None: return False
    lo, hi = parse_range(rng)
    return lo <= v <= hi

def parse_selector_scores(sel):
    m = re.search(r"scores=\{([^}]*)\}", sel)
    conds = []
    if m:
        for part in m.group(1).split(","):
            part = part.strip()
            if not part: continue
            k, v = part.split("=", 1)
            conds.append((k.strip(), v.strip()))
    has_nbt = "nbt=" in sel
    return conds, has_nbt

def select_players(sel, executor):
    if sel == "@s":
        return [executor] if executor is not None else []
    if sel.startswith("@a") or sel.startswith("@p") or sel.startswith("@e"):
        conds, has_nbt = parse_selector_scores(sel)
        out = []
        for p in players:
            ok = all(score_matches(p, k, v) for k, v in conds)
            if ok and has_nbt:
                ok = sim_holding_ken[0]
            if ok:
                out.append(p)
        return out
    return []

def resolve_holder(h, executor):
    if h == "@s": return executor
    return h  # #game, #five, #mod, player name, etc.

def set_score(holder, obj, val, executor):
    if holder == "@a":
        for p in players: scores[(p, obj)] = val
    elif holder == "@s":
        scores[(executor, obj)] = val
    else:
        scores[(holder, obj)] = val

def add_score(holder, obj, delta, executor, sign=1):
    if holder == "@a":
        for p in players: scores[(p, obj)] = scores.get((p, obj), 0) + sign*delta
    elif holder == "@s":
        scores[(executor, obj)] = scores.get((executor, obj), 0) + sign*delta
    else:
        scores[(holder, obj)] = scores.get((holder, obj), 0) + sign*delta

def reset_score(holder, obj, executor):
    tgt = players if holder == "@a" else ([executor] if holder == "@s" else [holder])
    for p in tgt: scores.pop((p, obj), None)

def enable_trigger(holder, obj, executor):
    tgt = players if holder == "@a" else ([executor] if holder == "@s" else [holder])
    for p in tgt: enabled.add((p, obj))

def sb_get(holder, obj):
    return scores.get((holder, obj), 0)

def run_scoreboard(tokens, executor):
    if tokens[1] == "objectives" and tokens[2] == "add":
        objectives[tokens[3]] = tokens[4] if len(tokens) > 4 else "dummy"; return None
    if tokens[1] == "players":
        op = tokens[2]; holder = tokens[3]
        if op == "set":
            set_score(holder, tokens[4], int(tokens[5]), executor)
        elif op == "add":
            add_score(holder, tokens[4], int(tokens[5]), executor, +1)
        elif op == "remove":
            add_score(holder, tokens[4], int(tokens[5]), executor, -1)
        elif op == "reset":
            reset_score(holder, tokens[4], executor)
        elif op == "enable":
            enable_trigger(holder, tokens[4], executor)
        elif op == "get":
            return sb_get(resolve_holder(holder, executor), tokens[4])
        elif op == "operation":
            h1, o1, oper, h2, o2 = tokens[3], tokens[4], tokens[5], tokens[6], tokens[7]
            a = scores.get((resolve_holder(h1, executor), o1), 0)
            b = scores.get((resolve_holder(h2, executor), o2), 0)
            if oper == "=": a = b
            elif oper == "%=": a = a % b if b else 0
            elif oper == "+=": a += b
            elif oper == "-=": a -= b
            scores[(resolve_holder(h1, executor), o1)] = a
        return None
    return None

def apply_store(store, executor, res):
    kind = store[0]
    if kind == "bossbar":
        bossbar[(store[1], store[2])] = res
    elif kind == "score":
        scores[(resolve_holder(store[1], executor), store[2])] = res

def smart_split(s):
    """Split auf Leerzeichen, aber NICHT innerhalb von []{}'' oder \"\"."""
    out, buf, depth, quote = [], [], 0, None
    for ch in s:
        if quote:
            buf.append(ch)
            if ch == quote: quote = None
            continue
        if ch in "'\"":
            quote = ch; buf.append(ch); continue
        if ch in "[{":
            depth += 1; buf.append(ch); continue
        if ch in "]}":
            depth -= 1; buf.append(ch); continue
        if ch == " " and depth == 0:
            if buf: out.append("".join(buf)); buf = []
            continue
        buf.append(ch)
    if buf: out.append("".join(buf))
    return out

def run_execute(cond, cmd, executor):
    toks = smart_split(cond)
    contexts = [executor]
    store = None
    i = 0
    while i < len(toks):
        w = toks[i]
        if w == "as":
            sel = toks[i+1]; i += 2
            newc = []
            for _ in contexts:
                newc.extend(select_players(sel, executor))
            contexts = newc
        elif w == "at":
            i += 2
        elif w in ("if", "unless"):
            kind = toks[i+1]
            if kind == "score":
                holder, obj, _m, rng = toks[i+2], toks[i+3], toks[i+4], toks[i+5]; i += 6
                keep = []
                for ex in contexts:
                    c = score_matches(resolve_holder(holder, ex), obj, rng)
                    if c == (w == "if"): keep.append(ex)
                contexts = keep
            elif kind == "entity":
                sel = toks[i+2]; i += 3
                matched = len(select_players(sel, executor)) > 0
                if not (matched == (w == "if")):
                    contexts = []
            else:
                raise ValueError("unknown cond " + kind)
        elif w == "store":
            assert toks[i+1] == "result"
            if toks[i+2] == "bossbar":
                store = ("bossbar", toks[i+3], toks[i+4]); i += 5
            elif toks[i+2] == "score":
                store = ("score", toks[i+3], toks[i+4]); i += 5
            else:
                raise ValueError("store " + toks[i+2])
        else:
            raise ValueError("unknown execute clause: " + w + " in: " + cond)
    for ex in contexts:
        res = run_command(cmd, ex)
        if res == RET: return RET
        if store is not None and isinstance(res, int):
            apply_store(store, ex, res)
    return None

def run_command(cmd, executor):
    cmd = cmd.strip()
    if cmd.startswith("execute "):
        if " run " not in cmd:
            raise ValueError("execute ohne run: " + cmd)
        cond, inner = cmd[len("execute "):].split(" run ", 1)
        return run_execute(cond, inner, executor)
    first = cmd.split()[0]
    if first == "scoreboard":
        return run_scoreboard(cmd.split(), executor)
    if first == "function":
        return run_function(cmd.split()[1], executor)
    if first == "schedule":
        toks = cmd.split()
        if toks[1] == "function":
            schedule[toks[2]] = toks[3]
        elif toks[1] == "clear":
            schedule.pop(toks[2], None)
        return None
    if first == "return":
        return RET
    # no-ops: tellraw, title, playsound, give, clear, bossbar, particle, ...
    return None

def run_function(name, executor):
    if name not in functions:
        raise ValueError("FUNKTION FEHLT: " + name)
    DEPTH[0] += 1
    if DEPTH[0] > 200:
        raise RuntimeError("Rekursion zu tief bei " + name)
    for line in functions[name]:
        res = run_command(line, executor)
        if res == RET:
            break
    DEPTH[0] -= 1
    return None

def do_tick():
    run_function("aisu_escape:tick", None)

def trigger(player, obj, val):
    assert (player, obj) in enabled, f"TRIGGER NICHT FREIGESCHALTET: {obj} fuer {player}"
    scores[(player, obj)] = val
    enabled.discard((player, obj))  # MC deaktiviert nach Nutzung

# ---------------- Lint: Mehrfach-Leerzeichen zwischen Argumenten ----------------
# Minecraft 1.21.x liest mehrfache Leerzeichen zwischen Argumenten als leeres
# Argument -> "Unknown criterion ''" o.ae. JSON-/String-Inhalt bleibt erlaubt,
# daher normalisieren wir klammer-/quote-bewusst und vergleichen.
print("=== 0) Lint: Argument-Leerzeichen ===")
lint_fail = []
for fname, flines in functions.items():
    for i, ln in enumerate(flines, 1):
        s = ln.strip()
        if not s or s.startswith("#"):
            continue
        if " ".join(smart_split(ln)) != ln:
            lint_fail.append(f"{fname} Zeile {i}: mehrfache Leerzeichen zwischen Argumenten")
if lint_fail:
    print(f" FAIL {len(lint_fail)} Zeile(n) mit problematischen Leerzeichen:")
    for m in lint_fail: print("   -", m)
    sys.exit(1)
print("  OK  keine problematischen Leerzeichen zwischen Argumenten")

# ---------------- Szenario ----------------
FAIL = []
def check(cond, msg):
    print(("  OK  " if cond else " FAIL ") + msg)
    if not cond: FAIL.append(msg)

print("=== 1) Weltstart: load ausfuehren, Spieler betritt Welt ===")
run_function("aisu_escape:load", None)
players.append("Kind")
check(scores.get(("#game","ak_state")) == 0, "ak_state = 0 (bereit) nach load")
do_tick()
check(scores.get(("Kind","ak_seen")) == 1, "Spieler wurde begruesst (ak_seen=1)")
check(("Kind","ak_route") in enabled, "ak_route ist freigeschaltet (Menue klickbar ohne Cheats)")

print("=== 2) Route 'Zaun' waehlen (per Trigger, ohne Cheats) ===")
trigger("Kind","ak_route",1)
do_tick()
check(scores.get(("#game","ak_state")) == 1, "Lauf gestartet (ak_state=1)")
check(scores.get(("#game","ak_time")) == 900, "Zeit = 900 (leichte Route)")
check(scores.get(("#game","ak_stage")) == 1, "Stufe 1 (Caesar) aktiv")
check(("Kind","ak_dial") in enabled, "Chiffrier-Rad freigeschaltet")

print("=== 3) Caesar falsch, dann richtig ===")
trigger("Kind","ak_dial",5)
do_tick()
check(scores.get(("#game","ak_stage")) == 1, "falsche Zahl -> bleibt Stufe 1")
check(("Kind","ak_dial") in enabled, "Rad nach Fehler wieder freigeschaltet")
trigger("Kind","ak_dial",3)
do_tick()
check(scores.get(("#game","ak_stage")) == 2, "Caesar geloest -> Stufe 2 (Alarm)")
check(("Kind","ak_alarm") in enabled, "Alarm-Code freigeschaltet")

print("=== 4) Alarm falsch (Zeitstrafe), dann richtig ===")
t_before = scores.get(("#game","ak_time"))
trigger("Kind","ak_alarm",42)
do_tick()
check(scores.get(("#game","ak_time")) == t_before - 10, "falscher Alarm -> 10 s Abzug")
check(("Kind","ak_alarm") in enabled, "Alarm nach Fehler wieder freigeschaltet")
trigger("Kind","ak_alarm",1001)
do_tick()
check(scores.get(("#game","ak_stage")) == 3, "Alarm geloest -> Stufe 3 (Kamera)")
check(("Kind","ak_cam") in enabled, "Kamera-PIN freigeschaltet")

print("=== 5) Kamera-PIN richtig ===")
trigger("Kind","ak_cam",1946)
do_tick()
check(scores.get(("#game","ak_stage")) == 4, "Kamera geloest -> Stufe 4 (Log)")
check(("Kind","ak_log") in enabled, "Freie-Minute freigeschaltet")

print("=== 6) Log richtig -> Sieg ===")
trigger("Kind","ak_log",25)
do_tick()
check(scores.get(("#game","ak_state")) == 2, "alle geloest -> ENTKOMMEN (ak_state=2)")
check(("Kind","ak_route") in enabled, "Menue wieder da (nochmal spielen ohne Cheats)")

print("=== 7) Neustart per Menue, dann Countdown ablaufen lassen (Lose) ===")
trigger("Kind","ak_route",3)   # schwere Route
do_tick()
check(scores.get(("#game","ak_state")) == 1, "neuer Lauf gestartet")
check(scores.get(("#game","ak_time")) == 300, "Zeit = 300 (schwere Route)")
scores[("#game","ak_time")] = 1
run_function("aisu_escape:countdown", None)  # 1 -> 0 -> lose
check(scores.get(("#game","ak_state")) == 3, "Zeit abgelaufen -> Lose (ak_state=3)")
check(("Kind","ak_route") in enabled, "Menue nach Lose wieder da")

print("=== 8) Geheime Losung 'Ken sent me' ===")
trigger("Kind","ak_route",2)
do_tick()
base = scores.get(("#game","ak_time"))
sim_holding_ken[0] = True
do_tick()
check(scores.get(("Kind","ak_secret")) == 1, "Losung erkannt (ak_secret=1)")
check(scores.get(("#game","ak_time")) == base + 60, "Schmuggler-Bonus +60 s")
sim_holding_ken[0] = False
do_tick()
check(scores.get(("Kind","ak_secret")) == 1, "Losung bleibt einmalig (kein Doppel-Bonus)")

print()
if FAIL:
    print(f"### {len(FAIL)} FEHLER ###")
    for m in FAIL: print(" -", m)
    sys.exit(1)
print("### ALLE LOGIK-CHECKS BESTANDEN ###")
