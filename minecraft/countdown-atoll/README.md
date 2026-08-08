# Countdown auf dem Atoll — Kapitel 1 (Prototyp)

Ein Vanilla-**Datapack** + **Resource Pack** für Minecraft Java Edition. Erster
spielbarer Ausschnitt der aisukurimu-Escape-Mod: ein Countdown läuft, quietschende
Drohnen-Ambience baut Druck auf, und du musst einen verschlüsselten Funkspruch
(Caesar-Chiffre) knacken, um das letzte Boot zu erreichen.

> Kein Mod-Loader nötig. Läuft in reinem Vanilla ab **Minecraft 1.21** und in
> allen neueren 1.21.x-Versionen (`supported_formats` weit gesetzt).

Design-Hintergrund und Gesamtkonzept: siehe `docs/minecraft-escape-mod-konzept.md`.

---

## Installation

> ⚠️ **Wichtig:** Das ist ein **Datapack**, KEINE Mod. Zieh es **nicht** ins
> „Mods"-Fenster (Fabric/ModMenu) — das funktioniert nicht. Datapacks werden
> pro Welt geladen. Fertige ZIPs zum Download liegen unter
> `public/downloads/` (`countdown-atoll-datapack.zip`, `-resourcepack.zip`).

### A) Datapack laden (das eigentliche Spiel)

Am einfachsten über die Welterstellung:

1. Minecraft starten → **Einzelspieler** → **Neue Welt erstellen**.
2. Im Erstell-Menü auf **Datenpakete** (Data Packs) klicken.
3. `countdown-atoll-datapack.zip` ins Fenster ziehen → es erscheint links →
   mit dem Pfeil **nach rechts** in „Ausgewählt" schieben.
4. **Fertig** → **Welt erstellen**. Beim Betreten erscheinen ein Titel und im
   Chat das **Routen-Menü** — Route anklicken, fertig.

> **Modus:** **Kreativ** empfohlen (keine Gegner/Hunger, entspanntes Rätseln).
> **Cheats werden NICHT benötigt** — die Bedienung läuft komplett über
> anklickbare `/trigger`-Menüs. (Erscheint kein Menü: einmal die Welt neu
> betreten; das Menü kommt automatisch, sobald du in der Welt bist.)

Alternativ (bestehende Welt): das ZIP in
`.minecraft/saves/<DEINE_WELT>/datapacks/` legen und im Chat `/reload` tippen.
Im ZIP liegen `pack.mcmeta`, `pack.png` und `data/` direkt in der Wurzel — genau
so muss ein Datapack aufgebaut sein.

### B) Resource Pack aktivieren (optional — nur für den Drohnen-Sound)

1. **Optionen** → **Ressourcenpakete** → **Paket-Ordner öffnen**.
2. `countdown-atoll-resourcepack.zip` hineinlegen, links auf die rechte Seite
   schieben, **Fertig**.
   - Für den Drohnen-Sound zusätzlich die `.ogg`-Datei ergänzen — siehe
     `resourcepack/assets/aisu_escape/sounds/ambient/PLATZHALTER-drone_squeak.md`.
   - Ohne die `.ogg` läuft alles trotzdem, nur ohne Drohnen-Ambience.

> **Version:** Minecraft Java **1.21+**. Ist das Datapack ausgegraut /
> „inkompatibel", stimmt die Minecraft-Version nicht.

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
5. **Rätsel 3 — Kamera** (schaltet sich nach Rätsel 2 frei): Ein Heft
   *Kamera-Steuerung* erscheint. Die Kamera läuft noch auf der **Werks-PIN** — ein
   Schild verrät „Anlage errichtet **1946**". Gib die naheliegende Zahl ein:
   ```
   /trigger ak_cam set <zahl>
   ```
   Richtig = **1946**. Lernmoment: Werks-PINs / Standard-Passwörter sind die
   häufigste echte Sicherheitslücke.
6. **Rätsel 4 — Patrouillen-Log** (schaltet sich nach Rätsel 3 frei): Ein Buch
   *Patrouillen-Log* listet die Minuten, zu denen die Wache am Steg vorbeikommt:
   `05 10 15 20 __ 30 35`. Genau eine Minute fehlt — dann ist der Steg frei. Gib
   die fehlende Zahl ein:
   ```
   /trigger ak_log set <zahl>
   ```
   Richtig = **25**. Lernmoment: Logs verraten Muster, und Muster verraten die
   Lücke — so arbeitet Forensik.
7. Alle vier Rätsel gelöst → **Entkommen**, du bekommst einen Bestenlisten-Code.
8. Läuft die Zeit ab: kein „Game Over" — ein Klick auf **Nochmal versuchen**
   setzt alles zurück.

Kurze Anleitung im Spiel: Klick auf **[ ? So wird gespielt ]** im Startmenü oder
`/function aisu_escape:hilfe`.

### 🥚 Geheime Losung (Easter Egg)

Auf der Insel geht das Gerücht von einer **Schmuggler-Luke**. Der Schmuggler nimmt
keine Codes — nur die alte Losung. Ein Hinweis darauf ist ins **Patrouillen-Log**
gekritzelt (letzte Seite).

**So löst du es:** Nimm ein **Papier**, benenne es im **Amboss** in genau
`Ken sent me` um und **halte es in der Hand**. Der Schmuggler erkennt die Losung →
**+60 Sekunden** und ein geheimer Bonus-Code. Rein optional, kein Muss zum
Entkommen.

> Technik-Hinweis: Text-Losungen kann Minecraft nicht per `/trigger` abfragen
> (nur Zahlen). Deshalb läuft das über einen im Amboss umbenannten Gegenstand,
> den das Datapack in der Hand erkennt. Die Erkennung deckt zwei NBT-Formen ab
> (siehe `tick.mcfunction`) — falls der erste Test zeigt, dass eure Version den
> Item-Namen anders speichert, ist das die eine Stelle zum Nachjustieren.

Manueller Neustart jederzeit: `/function aisu_escape:reset`

---

## Was der Prototyp zeigt (und was noch fehlt)

**Drin:**
- Countdown mit Bossbar + Actionbar, drei Schwierigkeits-Routen mit
  unterschiedlicher Zeit (adaptiver Countdown).
- Drohnen-Ambient-Schleife mit 3 Lautstärke-Stufen je nach Restzeit; Warn-Puls
  ab 5 Min bzw. jede Sekunde unter 1 Min.
- **Rätsel-Kette (4 Stufen):** Caesar-Chiffre → Alarmanlage (NOT-Gatter) →
  Kamera (Werks-PIN) → Patrouillen-Log (Forensik); erst alle vier gelöst =
  Entkommen. Jede Stufe voll spielbar über Trigger-Eingaben mit
  Falsch/Richtig-Rückmeldung; falscher Alarm kostet Zeit. Jede Stufe bildet eine
  reale Angriffsklasse ab (Krypto / Logik / Default-Passwort / Log-Analyse).
- **Easter Egg:** geheime Losung `Ken sent me` (Amboss-Umbenennung) mit Cue im
  Log-Buch → Zeit-Bonus + Geheim-Code.
- In-Game-Hilfe (`/function aisu_escape:hilfe` bzw. Startmenü-Knopf).
- Sieg-/Verlier-/Reset-Ablauf inkl. Bestenlisten-Code + Methoden-Rückblick.

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
    hilfe.mcfunction        # kurze Spielanleitung im Chat
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
      alarm_solved.mcfunction   # richtig -> schaltet Rätsel 3 frei
      give_camera.mcfunction    # Rätsel 3: Kamera-Steuerung-Buch (Werks-PIN)
      camera_wrong.mcfunction   # falsche PIN -> Rückmeldung
      camera_solved.mcfunction  # richtig -> schaltet Rätsel 4 frei
      give_log.mcfunction       # Rätsel 4: Patrouillen-Log-Buch (Forensik) + Cue
      log_wrong.mcfunction      # falsche Minute -> Rückmeldung
      log_solved.mcfunction     # richtig -> Sieg
    secret/
      found.mcfunction          # Easter Egg: Losung "Ken sent me" erkannt
resourcepack/
  pack.mcmeta
  assets/aisu_escape/sounds.json
  assets/aisu_escape/sounds/ambient/   # hier kommt drone_squeak.ogg rein
```
