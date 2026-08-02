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
3. **Funkspruch lesen** (Rechtsklick): Der Zugangscode `E R R W` ist mit einer
   Caesar-Chiffre verschoben. Finde heraus, um wie viele Stellen — und stelle das
   Chiffrier-Rad darauf ein:
   ```
   /trigger ak_dial set <zahl>
   ```
   (Im Buch gibt es dafür einen klickbaren Button, der den Befehl vorbereitet.)
4. Richtige Verschiebung = **3** (ERRW → BOOT). Triffst du sie, ist das Rätsel
   gelöst → **Entkommen**, und du bekommst einen Bestenlisten-Code.
   Falsche Zahl = kurze Rückmeldung, weiter probieren.
5. Läuft die Zeit ab: kein „Game Over" — ein Klick auf **Nochmal versuchen**
   setzt alles zurück.

Manueller Neustart jederzeit: `/function aisu_escape:reset`

---

## Was der Prototyp zeigt (und was noch fehlt)

**Drin:**
- Countdown mit Bossbar + Actionbar, drei Schwierigkeits-Routen mit
  unterschiedlicher Zeit (adaptiver Countdown).
- Drohnen-Ambient-Schleife mit 3 Lautstärke-Stufen je nach Restzeit; Warn-Puls
  ab 5 Min bzw. jede Sekunde unter 1 Min.
- Caesar-Rätsel voll spielbar über das `ak_dial`-Trigger-Rad, mit
  Falsch/Richtig-Rückmeldung.
- Sieg-/Verlier-/Reset-Ablauf inkl. Bestenlisten-Code für die Website.

**Bewusst noch nicht (kommt in den nächsten Kapiteln):**
- Gebaute Insel-Map, Kameras, Patrouillen/NPCs, weitere Rätsel der Kette.
- Echte Tür/Bootssteg, die sich beim Lösen öffnet (aktuell = Sofort-Sieg).
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
    tick.mcfunction         # liest das Chiffrier-Rad aus
    win / lose / reset.mcfunction
    puzzle/
      give_radio.mcfunction     # Funkspruch-Buch (Caesar)
      caesar_solved.mcfunction  # richtige Verschiebung -> Sieg
      caesar_wrong.mcfunction   # falsche Zahl -> Rückmeldung
resourcepack/
  pack.mcmeta
  assets/aisu_escape/sounds.json
  assets/aisu_escape/sounds/ambient/   # hier kommt drone_squeak.ogg rein
```
