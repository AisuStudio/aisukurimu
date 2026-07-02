---
order: 8
title: "Aufgabe 8 + 9 — Mein Rechner unter der Lupe"
description: "Schau unter die Motorhaube deines Rechners — Hardware, Prozesse, Pipes und Umleitungen."
slug: computer-under-magnifier
category: hacking
subcategory: terminal-system
level: 2
ageMin: 10
session: 4
exercises: [8, 9]
duration: 45
requiredTools: [terminal, powershell]
platforms: [mac, windows]
tags: [terminal, powershell, sysctl, processes, pipe, redirect]
image: /images/AK_EX_0008.jpg
date: 2026-05-18
language: de
---

# Aufgabe 8 + 9 — Mein Rechner unter der Lupe

> **Dein Ziel:** Finde heraus, welche Hardware in deinem Rechner steckt — und sieh nach, welche Programme im Hintergrund arbeiten, auch wenn du nichts machst.

Du brauchst **Terminal** (Mac) oder **PowerShell** (Windows) — das kennst du schon aus Aufgabe 7. Falls nicht → [Werkzeuge-Seite](/werkzeuge/)

---

## Aufgabe 8 — Was steckt drin?

Wie ein Mechaniker, der unter die Motorhaube schaut: Wir fragen den Rechner direkt, wie sein Innenleben aussieht.

### Welcher Prozessor?

**macOS · Terminal**
```bash
sysctl machdep.cpu.brand_string
```

**Windows · PowerShell**
```powershell
Get-CimInstance Win32_Processor |
  Select Name
```

Der **Prozessor** ist das Gehirn deines Rechners. Er sagt dir jetzt seinen vollen Namen.

### Wie viele Kerne?

**macOS · Terminal**
```bash
sysctl hw.ncpu
```

**Windows · PowerShell**
```powershell
Get-CimInstance Win32_Processor |
  Select NumberOfCores
```

Moderne Prozessoren haben mehrere **Kerne** — wie mehrere Gehirne in einem Kopf. Jeder kann gleichzeitig an etwas anderem arbeiten.

### Wie viel Arbeitsspeicher?

**macOS · Terminal**
```bash
sysctl hw.memsize
```

**Windows · PowerShell**
```powershell
Get-CimInstance Win32_ComputerSystem |
  Select TotalPhysicalMemory
```

> **Hinweis:** Auf neueren Macs (Apple Silicon — M1, M2, M3 …) kann `sysctl hw.memsize` leer bleiben. Dann schau stattdessen unter: **Apfel-Menü → Über diesen Mac** — dort steht der RAM direkt.

**RAM** ist der Kurzzeitspeicher — was gerade benutzt wird, liegt dort. Die Zahl kommt in **Bytes** — der kleinsten Speichereinheit. 1 GB = 1.024 × 1.024 × 1.024 Bytes. Um auf GB zu kommen:

```
Bytes ÷ 1.073.741.824 = GB
```

Beispiel: `8.589.934.592 ÷ 1.073.741.824 = 8 GB`

### Wie voll ist die Festplatte?

**macOS · Terminal**
```bash
df -h /
```

**Windows · PowerShell**
```powershell
Get-Volume C
```

Du siehst, wie groß deine Festplatte ist und wie viel davon schon belegt ist. Das `-h` beim Mac heißt "human-readable" — also für Menschen lesbar.

### Wie viele Apps installiert?

**macOS · Terminal**
```bash
ls /Applications | wc -l
```

**Windows · PowerShell**
```powershell
Get-ChildItem 'C:\Program Files' |
  Measure-Object
```

Hier passiert etwas **Neues**: das Zeichen `|` heißt **Pipe**. Es verbindet zwei Befehle — das erste schreibt seine Ausgabe, das zweite liest sie direkt ein, wie Wasser durch ein Rohr. Hier: `ls` listet die Apps auf, `wc -l` zählt die Zeilen. Befehle kann man zusammenstecken wie Lego.

> **Windows-Hinweis:** `Get-ChildItem 'C:\Program Files'` zählt Ordner in Program Files — das ist nicht dasselbe wie App-Bundles beim Mac, gibt aber eine gute Schätzung.

### 🔎 Mini-Forscherfrage

Rechne `hw.memsize` mit der Formel oben in GB um — wie viel hat dein Rechner? Und: Warum gibt `df -h /` die Größe schon fertig in GB oder TB, aber `sysctl hw.memsize` in rohen Bytes? Was ist da der Unterschied?

---

## Aufgabe 9 — Was tut mein Rechner gerade?

Wie ein Geheimagent, der zuhört: Wir schauen zu, was alles im Hintergrund läuft — auch wenn du gerade "nichts machst".

### Die Top-Prozesse jetzt

**macOS · Terminal**
```bash
top -l 1 | head -20
```

**Windows · PowerShell**
```powershell
Get-Process |
  Sort CPU -Descending |
  Select -First 20
```

Du siehst die ersten 20 **Prozesse**. Ein Prozess ist ein laufendes Programm. Beim Mac filtert `| head -20` die ersten 20 Zeilen heraus, bei Windows tut `| Select -First 20` das Gleiche.

### Wer braucht am meisten CPU?

**macOS · Terminal**
```bash
top -l 1 -o cpu | head -15
```

**Windows · PowerShell**
```powershell
Get-Process |
  Sort CPU -Descending |
  Select -First 15
```

Jetzt sortiert: ganz oben steht der Prozess, der gerade am meisten **CPU** braucht. Vielleicht dein Browser? Vielleicht eine App im Hintergrund?

### Wie viele Prozesse laufen insgesamt?

**macOS · Terminal**
```bash
ps aux | wc -l
```

**Windows · PowerShell**
```powershell
(Get-Process).Count
```

Wahrscheinlich überraschend viele — der Rechner ist *nie* wirklich untätig.

### Alles in eine Datei umleiten

**macOS · Terminal**
```bash
ps aux > meine_prozesse.txt
```

**Windows · PowerShell**
```powershell
Get-Process > meine_prozesse.txt
```

Das Zeichen `>` ist eine **Umleitung**. Statt die Ausgabe auf den Bildschirm zu schicken, schreibt sie der Rechner in die Datei `meine_prozesse.txt`. Genau dasselbe Prinzip wie unsere Python-Datei aus Aufgabe 6 — nur eine Ebene tiefer.

### 🔎 Mini-Forscherfrage

Welcher Prozess auf deinem Rechner frisst gerade am meisten Arbeitsspeicher? Und: Wie viele Prozesse laufen, wenn du gerade *nichts* machst? Warum so viele, wenn du doch nichts tust?
