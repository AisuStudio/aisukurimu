---
title: "Aufgabe 8 + 9 — Mein Rechner unter der Lupe"
slug: computer-under-magnifier
category: hacker
subcategory: terminal-system
difficulty: 2
ageMin: 10
session: 4
exercises: [8, 9]
duration: 45
requiredTools: [terminal, powershell]
platforms: [mac, windows]
tags: [terminal, powershell, sysctl, processes, pipe, redirect]
date: 2026-05-18
language: de
---

# Aufgabe 8 + 9 — Mein Rechner unter der Lupe

> **Dein Ziel:** Finde heraus, welche Hardware in deinem Rechner steckt — und sieh nach, welche Programme im Hintergrund arbeiten, auch wenn du nichts machst.

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

**RAM** ist der Kurzzeitspeicher — was gerade benutzt wird, liegt dort. Die Zahl ist in **Bytes**. Um auf GB zu kommen: durch 1.073.741.824 teilen (das sind 1024 × 1024 × 1024).

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

Hier passiert etwas **Neues**: das Zeichen `|` heißt **Pipe**. Es verbindet zwei Befehle: `ls` listet die Apps auf, `wc -l` zählt die Zeilen. Befehle kann man zusammenstecken wie Lego.

### 🔎 Mini-Forscherfrage

Rechne `hw.memsize` in GB um — wie viel hat dein Rechner? Und: Warum gibt `df -h /` die Größe in GB oder TB, aber `sysctl hw.memsize` in Bytes? Was ist da der Unterschied?

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
