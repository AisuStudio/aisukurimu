---
title: "Aufgabe 7 — Hallo, mein Rechner!"
description: "Sprich zum ersten Mal direkt mit deinem Rechner — er sagt wer er ist und wie lange er läuft."
slug: hello-my-computer
category: hacking
subcategory: terminal-basics
level: 1
ageMin: 10
session: 3
exercise: 7
duration: 25
requiredTools: [terminal, powershell]
platforms: [mac, windows]
tags: [terminal, powershell, commands, whoami, hostname, date, uptime]
image: /images/AK_EX_0007.jpg
date: 2026-05-18
language: de
---

# Aufgabe 7 — Hallo, mein Rechner!

> **Dein Ziel:** Sprich zum ersten Mal direkt mit deinem Rechner — ohne App, ohne Internet. Er wird dir sagen, wer er ist, wie er heißt und wie lange er schon läuft.

## Was du brauchst

Nur deinen Rechner und seinen **Befehlsraum**. Auf dem Mac heißt der **Terminal**, auf Windows **PowerShell**. Beide sind ein schwarzes (oder weißes) Fenster, in dem du dem Rechner direkt etwas sagen kannst — mit Worten, nicht mit Klicks.

## Was neu ist

**Befehle**. Ein Befehl ist ein winziges Programm, das nur eine einzige Aufgabe hat. Du tippst ihn, drückst **Enter**, und der Rechner antwortet sofort.

## Schritt 1 — Befehlsraum öffnen

**macOS · Terminal**
```bash
# Drücke:  Cmd + Leertaste
# Tippe:   Terminal
# Drücke:  Enter
```

**Windows · PowerShell**
```powershell
# Drücke:  Windows-Taste
# Tippe:   PowerShell
# Drücke:  Enter
```

## Schritt 2 — Wer bin ich?

Dein erster Befehl. Tippe ihn ein und drücke **Enter**:

**macOS · Terminal** | **Windows · PowerShell**
```bash
whoami
```
```powershell
whoami
```

Der Rechner sagt dir seinen **Benutzernamen** für dich — also wie du auf diesem Computer heißt.

## Schritt 3 — Wie heißt der Rechner?

**macOS · Terminal** | **Windows · PowerShell**
```bash
hostname
```
```powershell
hostname
```

Das ist der **Name des Computers** selbst — unter diesem Namen erkennen ihn andere Rechner im Netzwerk.

## Schritt 4 — Welches Datum hat der Rechner?

**macOS · Terminal**
```bash
date
```

**Windows · PowerShell**
```powershell
Get-Date
```

Jeder Rechner hat seine eigene innere Uhr. Stimmt sie mit deiner Wand-Uhr überein?

## Schritt 5 — Wie lange läuft der Rechner schon?

**macOS · Terminal**
```bash
uptime
```

**Windows · PowerShell**
```powershell
Get-Uptime
```

Diese Zahl wird zurückgesetzt, wenn der Rechner neu startet. Wenn sie sehr groß ist, hat dein Rechner schon eine Weile durchgehalten.

## 🔎 Mini-Forscherfrage

Sind `whoami` und `hostname` dasselbe? Vergleicht es untereinander in der Gruppe — haben zwei Kinder vielleicht denselben Benutzernamen, obwohl sie auf verschiedenen Rechnern sitzen? Oder denselben Hostname?
