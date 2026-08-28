# Logik-Test (offline, ohne Minecraft)

`logic_sim.py` bildet die von diesem Datapack genutzten Befehle nach
(Scoreboard, `execute if/unless`, Funktionsaufrufe, Trigger, Schedule) und
spielt die komplette Rätsel-Kette als Fake-Spieler durch.

```sh
python3 test/logic_sim.py
```

Prüft: Begrüßung/Menü, Routenwahl **ohne Cheats** (per `/trigger`), die vier
Rätsel-Stufen inkl. Falsch-/Richtig-Rückmeldung und Zeitstrafe, Sieg, Verlieren
(Countdown), Neustart und das „Ken sent me"-Easter-Egg.

**Grenzen:** validiert die *Spiel-Logik*, nicht Minecrafts exakte Befehls-/
JSON-Syntax des echten Parsers. Für den vollen Test weiterhin einmal in
Minecraft Java 1.21+ laden.
