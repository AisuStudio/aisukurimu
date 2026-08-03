# Insel-Escape — Konzept für die aisukurimu Minecraft-Mod

> **Arbeitstitel:** *Countdown auf dem Atoll*
> **Zielgruppe:** Kinder 8–13 Jahre (dieselbe Spanne wie die aisu.lab-Übungen)
> **Kern-Idee:** Ein Escape-Szenario auf einer Insel. Man muss eine Kette von
> Rätseln lösen — jedes davon eine echte Sicherheits-/Hacking-Methode — um vor
> dem Start eines historischen Atomtests von der Insel zu fliehen.

Dieses Dokument ist die Design-Grundlage. Es beschreibt Story, Rätsel, Routen,
Gegner, Team-Modus, Audio, Erweiterbarkeit und die technische Umsetzung. Es ist
bewusst so geschrieben, dass daraus **Kapitel 1 als Datapack-Prototyp** gebaut
werden kann, ohne dass später etwas umgeworfen werden muss.

---

## 1. Warum das zu aisu.lab passt

Ein Pentest ist im Kern ein Escape-Room: **Recon → Zugang finden → Rechte
ausweiten → Ziel erreichen.** Genau diese Struktur gibt dem Spiel sein Gerüst.
Fast jede vorhandene Übung lässt sich in ein Insel-Rätsel übersetzen:

| aisu.lab-Übung | Insel-Rätsel |
|---|---|
| Caesar-Chiffre | Verschlüsselter Funkspruch im Wachhaus — ohne Schlüssel kein Zugang zum Labor |
| Assembler-Alarm (NOT/AND/OR) | Alarmanlage deaktivieren — Logikgatter als echte Redstone-Schaltung |
| Redstone-Bunker 1–3 | Der Bunker ist jetzt das Gebäude, in das man **einbricht** (Perspektivwechsel) |
| Terminal-Spiel (`whoami`, `ping`) | In-Game-Terminals in der Kommandozentrale |
| Browser-Inspector / Datenspuren-Detektiv | Versteckte Hinweise in Dokumenten, Logs und Aushängen finden |
| Rätsel-Serie Sicherheitsdenken | NPC-Dialoge mit Entscheidungen (Wache überzeugen statt Ausweis fälschen) |

**Leitprinzip:** Jedes Rätsel = eine reale Angriffsklasse, und daneben steht
immer die Verteidigung. Aus der Mod wird nicht „hacken lernen", sondern
„verstehen, warum Sicherheit schwer ist" — die Haltung der Website.

---

## 2. Story & Ton

- **Setting:** Ein verlassenes Forschungs-Atoll, historischer Anker: Bikini-Atoll
  1946. Es läuft eine **Evakuierung** — der Spieler ist zurückgelassen worden und
  muss vor dem Test-Countdown zum letzten Boot / Funkgerät.
- **Ton:** Spannung durch Countdown, **kein Explosions-Horror.** Scheitern =
  Countdown startet neu, kein dramatisches „Game Over". Die Bombe wird als
  historisches Evakuierungs-Ereignis erzählt, nicht als Gewalt.
- **Medien-Bezug:** Passt tonal zu *WarGames*, das schon in der Medien-Sammlung
  liegt.

**Countdown-Mechanik:** Eine Bossbar zeigt die verbleibende Zeit. Fehler
(gesehen werden, Alarm auslösen) beschleunigen den Countdown, statt Leben
abzuziehen. Das hält es spannend statt frustrierend.

---

## 3. Rätsel-Katalog (Hacker-Methoden)

Jedes Rätsel vermittelt ein echtes Konzept — kein Hollywood-Hacking.

1. **Kryptographie** — Caesar-Chiffre (Funkspruch), später Steganografie
   (Nachricht in einem Buch, jeder 3. Buchstabe). Baut auf der Caesar-Übung auf.
2. **Logikgatter** — Alarm mit NOT/AND/OR als Redstone abschalten. Fortsetzung
   von Assembler-Alarm und Redstone-Bunker 2.
3. **Passwörter & Wortlisten** — 4-stelliges Schließfach; Ziffern-Hinweise in der
   Welt (Foto, Zettel). Lehrt, warum schwache Passwörter gefährlich sind.
4. **Social Engineering** — Wache lässt nur mit Tagescode/Ausweis durch; Ausweis
   in Dokumenten finden („Dumpster Diving"). Kein Lügen-Belohnen — Aufmerksamkeit.
5. **Netzwerk-Enumeration** — Terminal mit `ping`/`scan` zeigt, welche Systeme
   „online" und angreifbar sind. Fortsetzung des Terminal-Spiels.
6. **Log-Analyse / Forensik** — Patrouillen-Log mit Zeitstempeln verrät das
   Zeitfenster für einen freien Gang. Lehrt: Spuren lesen.
7. **Physical Security** — Redstone-Schloss mit richtiger Hebel-Reihenfolge
   (abstrahiertes Lock Picking). Knüpft an Redstone-Bunker an.
8. **Default-Passwörter / Fehlkonfiguration** — Kamera-System läuft noch auf
   `admin/admin`. Realistischstes Sicherheitsproblem überhaupt.

---

## 4. Kameras

Verbindet Stealth und Rätsel und schließt den Kreis zu Redstone-Bunker 2 (dort
**baut** das Kind ein Alarmsystem — hier **überwindet** es eins).

- Kameras haben einen sichtbaren Sichtkegel (Partikel / Redstone-Lampe).
  Durchlaufen → Alarm, Countdown beschleunigt.
- **Mehrere Lösungswege** je nach Können:
  - **Physisch:** Redstone-Kabel finden und durchtrennen.
  - **Digital:** am Terminal mit Default-Passwort abschalten.
  - **Umgehen:** toten Winkel finden (Schwenk-Rhythmus aus dem Log).

---

## 5. Routen (Schwierigkeit)

Drei Wege ab dem Start — wie in einem Stealth-Spiel:

- 🟢 **Der Zaun (leicht):** mehr Zeit, einfache Code-Rätsel, kaum Wachen.
- 🟡 **Die Kanalisation (mittel):** Logikgatter, eine Kamera, Zeitdruck.
- 🔴 **Das Hauptgebäude (schwer):** echte Terminal-Befehle, Patrouillen, wenig
  Zeit — aber der kürzeste Weg zum Boot.

**Adaptiver Countdown:** Leichtere Route = mehr Minuten auf der Uhr. „Schwer" ist
damit auch *riskanter*, nicht nur kniffliger — echtes Risiko/Belohnungs-Gefühl.
**Optionale Bonus-Rätsel** liefern Geheim-Codes für die Bestenliste, sind aber
keine Pflicht (Kür getrennt von Pflicht).

---

## 6. Sicherheitspersonal

Bewusst **nicht kampflastig** (Zielgruppe + Ton):

- **Patrouillen mit festem Muster** (Datapack-Function auf Pfaden). Gesehen
  werden kostet **Zeit**, nicht Leben.
- **Wachen als NPCs mit Dialog:** manche lassen mit richtigem Ausweis/Code durch
  → Personal wird zum Rätsel, nicht zum Gegner.
- **Schichtwechsel:** ein Log verrät die Pause einer Wache → freier Gang.
  Belohnt Aufmerksamkeit.
- Technisch: Vanilla-Mobs mit KI-Pfaden im Datapack reichen für den ersten Wurf;
  schöneres Verhalten später über die Fabric-Mod.

---

## 7. Team-Modus

Minecraft ist von Natur aus Multiplayer — ein starkes Alleinstellungsmerkmal.

- **Kooperativ, gleiche Rätsel:** 2–4 Kinder helfen sich. Sofort machbar.
- **Rollen-Kooperation** (Highlight, echtes Red-Team-Gefühl):
  - **Späher** — erkundet, liest Logs, meldet Patrouillen-Zeiten.
  - **Code-Knacker** — sitzt am Terminal, löst Chiffre/Logik.
  - **Techniker** — schaltet Kameras/Redstone aus.
  - Manche Rätsel brauchen **zwei gleichzeitig** (getrennte Hebel, Code per Chat
    durchgeben) → erzwingt Kommunikation.
- **Gemeinsame Countdown-Bossbar** → geteilter Druck, echtes Teamgefühl.
- **Unterricht:** Lehrer hostet (Realms/LAN), Klasse in Teams, Team-Code am Ende
  in die Bestenliste.

---

## 8. Audio & Atmosphäre

Sound trägt bei einem Countdown-Spiel überproportional viel zur Spannung bei.
Custom-Sounds kommen über das **Resource Pack** (`sounds.json` + `.ogg`-Dateien).

- **Quietschende Drohnen-Ambient-Loops** (`ambient.drone.squeak`): tieffrequenter,
  leicht schräg schwebender Dauerton mit gelegentlichem metallischem Quietschen —
  vermittelt „verlassene Anlage unter Strom". Läuft als Endlos-Loop im
  Hintergrund, Lautstärke steigt subtil, je weniger Zeit auf der Uhr ist.
- **Countdown-Schichten:** ab bestimmten Zeit-Schwellen (z. B. < 5 min, < 1 min)
  legt sich ein zweiter, schnellerer Puls über die Drohne → hörbarer Druck ohne
  Text.
- **Ereignis-Sounds:** Alarm-Klang bei Kamera-Erkennung, ein „Klick-Entriegeln"
  bei gelöstem Schloss, ein Funkgeräusch beim Terminal-Zugang.
- **Umsetzung im Datapack:** Sounds per `/playsound` an Zonen/Trigger koppeln;
  die Drohne pro Spieler als loopenden `playsound` mit Nachtrigger, damit sie
  nahtlos weiterläuft.

> Assets: gemeinfreie/CC0-Loops als Platzhalter, später eigene Aufnahmen. Alle
> `.ogg` in Mono, damit die Positionierung im Raum funktioniert.

---

## 9. Erweiterbarkeit & Easter Eggs

Damit spätere Ergänzungen **trivial einzuhängen** sind, wird von Anfang an
modular gebaut:

- **Offenes Trigger-/Zonen-System:** eine generische „Spieler betritt Zone X /
  benutzt Item Y → Reaktion Z"-Mechanik (per `tick`-Function + Zonen-Prüfung).
  Ein neues Egg = eine neue Zone + eine neue Reaktion, **kein** Eingriff ins
  Bestehende.
- **Ein Egg = eine Function-Datei.** Rein/raus in Sekunden, nichts kann brechen.
- **Ein „geheimer Kanal":** ein ungenutztes Terminal-Kommando oder eine
  Blockkombination als späterer Einhängepunkt.

### 9a. Zeitlose Eggs (dürfen fest rein)

- **WarGames:** ein altes Terminal fragt „Shall we play a game?" → Mini-Rätsel.
- **Bunker-Rückverweis:** die exakte Redstone-Schaltung aus Redstone-Bunker 1
  versteckt → Bonus-Code für alle, die sie erkennen.
- **Bikini-Atoll 1946:** eine Akte mit dem echten Datum → Lern-Nugget als
  Belohnung.
- **Konami-Code** auf einem Nummernfeld → Skin/Titel/Bonus.
- **Der „ehrliche Weg":** verstecktes Egg für das Kind, das *keine* Kamera
  ausschaltet und trotzdem entkommt — belohnt sauberes Denken.
- **„Ken sent me"** *(umgesetzt in Kapitel 1)*: klassische Retro-Losung. Papier
  im Amboss in `Ken sent me` umbenennen und in der Hand halten → Schmuggler gibt
  Zeit-Bonus + Geheim-Code. Cue steckt im Patrouillen-Log-Buch.

### 9b. Austauschbare Eggs (mit dem Kurs aktualisieren)

Jugendsprache-/Meme-Referenzen altern schnell — deshalb **nur als Easter Egg,
nie in Pflicht-Texten**, und bewusst als „zu pflegen" markiert.

- **„67" als Zahl** statt als Text: Schließfach-Code 67, Kamera Nr. 67, Tür bei
  x=67 mit absurder Reaktion. Fügt sich in die vorhandene Code-Mechanik ein.
- **Reaktion statt Schild:** lieber ein Effekt (Sound, Partikel) als
  ausgeschriebener Spruch — Effekte altern langsamer.
- **Belohnung klein:** Titel/Partikel/Bonuspunkt, nie ein Nachteil für Spieler,
  die die Referenz nicht kennen.
- **Sparsam:** drei, vier gut versteckte sind kultig; zwanzig wirken bemüht.

> **Regel:** Der Lerninhalt (Rätsel-Erklärungen, Story) folgt weiter dem
> Qualitätsprofil — klares, einfaches Deutsch, keine Meme-Sprache. Eggs sind Kür.

---

## 10. Technische Umsetzung

Drei Stufen, empfohlen wird die Hybrid-Variante:

1. **Datapack + Resource Pack (Vanilla, kein Java).** Insel-Welt, Countdown per
   Scoreboard/Bossbar, Rätsel-Logik als Command-Functions, Dialoge per
   `/tellraw`, Sounds per Resource Pack. Läuft ohne Mod-Loader — Kinder ziehen es
   in den Weltordner. Deckt ~80 % ab.
2. **Fabric-/NeoForge-Mod (Java, MC 1.21+).** Nötig für echte Terminals mit
   Texteingabe, eigene GUIs (Chiffrier-Rad als Bildschirm), eigene Blöcke/Items
   (Schlüsselkarte, Geigerzähler). Modelle über Blockbench (steht schon auf der
   Werkzeuge-Seite).
3. **Hybrid (Favorit):** Datapack für Welt/Story/Countdown + kleine Fabric-Mod
   nur für Terminal-/Chiffre-Bildschirme. Großteil bleibt einfach wartbar, nur
   das echte Java-Nötige wird Java.

### Rückkopplung zur Website

Jedes Insel-Rätsel verweist auf die passende aisu.lab-Übung („Das hast du in
Redstone-Bunker Teil 2 gelernt"). Am Ende steht ein Code, den man auf
lab.aisu.studio eingibt → Eintrag in die bereits existierende Bestenliste. Die
Mod wird so zur **Abschlussprüfung des ganzen Kurses.**

---

## 11. Umfang & Roadmap

- **Kapitel 1 „Ankunft & Recon" (erster Wurf):** Insel-Map, 5–6 Rätsel als
  Datapack, Countdown, Drohnen-Ambient, Ende mit Bestenlisten-Code. Mit Claudes
  Hilfe in wenigen Sessions machbar.
- **Kapitel 2+:** weitere Routen, Kameras, Patrouillen, Team-Rollen.
- **Voller Ausbau:** eigene GUIs/Items über die Fabric-Mod, mehrwöchig, sauber in
  Kapitel-Releases schneidbar.

**Nächster Schritt:** Kapitel 1 als Datapack-Prototyp aufsetzen (Weltordner,
Countdown-Function, erstes Rätsel, Drohnen-Loop).
