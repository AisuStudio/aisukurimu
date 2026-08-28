# Hier fehlt noch die Sound-Datei

Lege in **diesen** Ordner die Datei:

```
drone_squeak.ogg
```

(Genau dieser Name, ohne den `PLATZHALTER-`-Text — die Zuordnung steht in
`assets/aisu_escape/sounds.json` als `aisu_escape:ambient/drone_squeak`.)

## Anforderungen an die Datei

- Format: **Ogg Vorbis** (`.ogg`) — MP3/WAV funktionieren in Minecraft nicht.
- **Mono**, damit der Klang im Raum positioniert werden kann.
- **Nahtlose Schleife** (loop-fähig): Anfang und Ende müssen ohne Knacken
  ineinander übergehen.
- Länge idealerweise **8 Sekunden** — genau das Intervall, mit dem
  `function aisu_escape:drone` den Sound neu abspielt. Bei anderer Länge die
  `8s` in `datapack/.../function/drone.mcfunction` anpassen.

## Klangidee

Tieffrequenter, leicht schräg schwebender Dauerton (Drohne) mit gelegentlichem
metallischem **Quietschen** — „verlassene Anlage unter Strom". Nicht zu laut, er
läuft im Hintergrund; die Lautstärke steuert das Datapack in drei Stufen je nach
Restzeit.

## Woher nehmen (CC0 / gemeinfrei)

- freesound.org (Filter auf CC0), Suchbegriffe: *drone hum*, *metal creak*,
  *industrial ambient loop*.
- Selbst bauen in Audacity: tiefen Sinus/Rausch-Layer + ein Quietsch-Sample,
  dann Effekt **Reverb**, und mit *Repeat*/Crossfade schleifenfest machen,
  Export als Ogg Vorbis (Mono).

> Wenn diese Datei fehlt, läuft das Datapack trotzdem fehlerfrei — es kommt nur
> kein Drohnen-Sound. Alles andere (Countdown, Warntöne, Rätsel) nutzt
> Vanilla-Sounds und funktioniert sofort.
