# Countdown auf dem Atoll — Kapitel 1 (Prototyp)

Ein Vanilla-**Datapack** + **Resource Pack** für Minecraft Java Edition. Erster
spielbarer Ausschnitt der aisukurimu-Escape-Mod: ein Countdown läuft, quietschende
Drohnen-Ambience baut Druck auf, und du musst einen verschlüsselten Funkspruch
(Caesar-Chiffre) knacken, um das letzte Boot zu erreichen.

> Kein Mod-Loader nötig. Läuft in reinem Vanilla ab **Minecraft 1.21**.
> Getestetes Ziel: 1.21+ (Datapack `pack_format` 48, Resource Pack `pack_format` 34).

Design-Hintergrund und Gesamtkonzept: siehe `docs/minecraft-escape-mod-konzept.md`.

---

## Installation

1. **Welt vorbereiten:** Erstelle in Minecraft eine neue Welt (Kreativmodus
   reicht). Cheats müssen **an** sein (für den Prototyp; die Vollversion braucht
   das nicht).
2. **Datapack:** Kopiere den Ordner `datapack/` in den `datapacks/`-Ordner deiner
   Welt und benenne ihn z. B. `countdown-atoll`:
   ```
   .minecraft/saves/<DEINE_WELT>/datapacks/countdown-atoll/
   ```
   (In diesem Ordner müssen `pack.mcmeta` und `data/` direkt liegen.)
3. **Resource Pack:** Kopiere den Ordner `resourcepack/` nach
   `.minecraft/resourcepacks/` (z. B. als `countdown-atoll-sounds`) und aktiviere
   ihn in den Minecraft-Einstellungen unter *Ressourcenpakete*.
   - Für den Drohnen-Sound zusätzlich die `.ogg`-Datei ergänzen — siehe
     `resourcepack/assets/aisu_escape/sounds/ambient/PLATZHALTER-drone_squeak.md`.
   - Ohne die `.ogg` läuft alles trotzdem, nur ohne Drohnen-Ambience.
4. **Laden:** Welt öffnen und im Chat `/reload` eingeben. Es erscheint das
   Routen-Auswahlmenü.

---

## Spielen

1. Nach `/reload` erscheinen drei anklickbare Routen im Chat:
   - 🟢 **Zaun (leicht)** — 15 Minuten
   - 🟡 **Kanalisation (mittel)** — 10 Minuten
   - 🔴 **Hauptgebäude (schwer)** — 5 Minuten
2. Route anklicken → der Countdown startet (Bossbar oben), du bekommst den
   **Funkspruch** ins Inventar.
3. **Rätsel 1 — Funkspruch** (Rechtsklick zum Lesen): Der Zugangscode `E R R W`
   ist mit einer Caesar-Chiffre verschoben. Finde heraus, um wie viele Stellen —
   und stelle das Chiffrier-Rad darauf ein:
   ```
   /trigger ak_dial set <zahl>
   ```
   Richtige Verschiebung = **3** (ERRW → BOOT). Falsche Zahl = kurze Rückmeldung,
   weiter probieren.
4. **Rätsel 2 — Alarmanlage** (schaltet sich nach Rätsel 1 frei): Ein neues Buch
   *Alarm-Panel* erscheint. Die Kontrollleuchten zeigen `0 1 1 0`. Ein **NOT-Gatter**
   dreht jedes Bit um → invertiere das Muster und gib es als Zahl ein:
   ```
   /trigger ak_alarm set <zahl>
   ```
   Richtig = **1001**. Falsch heult die Sirene kurz — und kostet **10 Sekunden**
   Countdown.
5. Beide Rätsel gelöst → **Entkommen**, du bekommst einen Bestenlisten-Code.
6. Läuft die Zeit ab: kein „Game Over" — ein Klick auf **Nochmal versuchen**
   setzt alles zurück.

Manueller Neustart jederzeit: `/function aisu_escape:reset`

---

## Was der Prototyp zeigt (und was noch fehlt)

**Drin:**
- Countdown mit Bossbar + Actionbar, drei Schwierigkeits-Routen mit
  unterschiedlicher Zeit (adaptiver Countdown).
- Drohnen-Ambient-Schleife mit 3 Lautstärke-Stufen je nach Restzeit; Warn-Puls
  ab 5 Min bzw. jede Sekunde unter 1 Min.
- **Rätsel-Kette (2 Stufen):** Caesar-Chiffre schaltet die Alarmanlage
  (NOT-Gatter) frei; erst beide gelöst = Entkommen. Beide voll spielbar über
  Trigger-Eingaben mit Falsch/Richtig-Rückmeldung; falscher Alarm kostet Zeit.
- Sieg-/Verlier-/Reset-Ablauf inkl. Bestenlisten-Code für die Website.

**Bewusst noch nicht (kommt in den nächsten Kapiteln):**
- Gebaute Insel-Map, Kameras, Patrouillen/NPCs, weitere Rätsel der Kette.
- Echte Tür/Bootssteg, die sich beim Lösen physisch öffnet (aktuell rein über
  Trigger-Eingabe statt gebauter Redstone-Tür).
- Team-Rollen, Custom-Items/GUIs (dafür später die kleine Fabric-Mod).
- Easter Eggs (das offene Trigger-/Zonen-System dafür ist im Konzept beschrieben).

---

## Datei-Übersicht

```
datapack/
  pack.mcmeta
  data/minecraft/tags/function/{load,tick}.json   # Hooks für Load & jeden Tick
  data/aisu_escape/function/
    load.mcfunction         # Setup + Routen-Menü (bei /reload)
    route/{easy,medium,hard}.mcfunction
    start.mcfunction        # Lauf starten, Funkspruch geben, Schleifen an
    countdown.mcfunction    # 1x/s: Zeit runter, Bossbar, Warntöne
    pulse_mid.mcfunction    # Warn-Tick alle 5 s (mittlerer Zeitbereich)
    drone.mcfunction        # Drohnen-Ambient-Schleife (alle 8 s)
    tick.mcfunction         # liest Chiffrier-Rad + Alarm-Code aus (je Stufe)
    win / lose / reset.mcfunction
    puzzle/
      give_radio.mcfunction     # Rätsel 1: Funkspruch-Buch (Caesar)
      caesar_wrong.mcfunction   # falsche Zahl -> Rückmeldung
      caesar_solved.mcfunction  # richtig -> schaltet Rätsel 2 frei
      give_alarm.mcfunction     # Rätsel 2: Alarm-Panel-Buch (NOT-Gatter)
      alarm_wrong.mcfunction    # falscher Code -> Sirene + 10 s Abzug
      alarm_solved.mcfunction   # richtig -> Sieg
resourcepack/
  pack.mcmeta
  assets/aisu_escape/sounds.json
  assets/aisu_escape/sounds/ambient/   # hier kommt drone_squeak.ogg rein
```
