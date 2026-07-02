---
title: "Aufgaben 1 – 3 — Hallo, Supercell!"
description: "Schreib dein erstes Programm, das mit Supercell spricht — und hol dir Daten aus deinem Brawl-Stars-Account ins Python."
slug: hello-supercell
category: coding
subcategory: brawlstars-api
level: 1
ageMin: 10
session: 1
exercises: [1, 2, 3]
duration: 90
requiredTools: [thonny, terminal, powershell]
platforms: [mac, windows]
tags: [python, api, json, http, f-string, for-loop, brawlstars]
image: /images/AK_EX_0001.jpg
date: 2026-05-18
language: de
---

# Hallo, Supercell!

> **Dein Ziel:** Du schreibst dein erstes Programm, das mit den Servern von Supercell spricht — und holst dir Daten über deinen eigenen Brawl-Stars-Account ins Python-Programm.

---

## Vorbereitung

Bevor das Programmieren losgeht, müssen wir einmalig ein paar Sachen einrichten. Keine Angst, das geht schnell.

### 1 · Befehlsraum öffnen

Dein Rechner hat einen **Befehlsraum**, in dem du ihm direkt etwas sagen kannst — mit Worten, nicht mit Klicks. Auf dem Mac heißt der **Terminal**, auf Windows **PowerShell**.

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

### 2 · Deine IP-Adresse herausfinden

Im Befehlsraum tippe ein und drücke **Enter**:

```bash
curl ifconfig.me
```

Du siehst eine Zahl wie `93.184.216.34`. Das ist deine **IP-Adresse** — sozusagen die Hausnummer deines Rechners im Internet. Schreib sie auf, du brauchst sie gleich.

### 3 · Bei developer.brawlstars.com anmelden

> ⚠️ **Das macht ihr zusammen mit dem Lehrer** — der API-Key braucht einen Account und eine echte E-Mail-Adresse.

Gehe auf **developer.brawlstars.com**, klicke **Sign up**, melde dich mit deiner **Schul-E-Mail** an und bestätige sie. Dann logge dich ein und klicke **Create New Key**. Trage als Name `mein-aisu-key` ein, als Beschreibung `aisukurimu-Kurs`, und bei **Allowed IP Addresses** deine eben gefundene IP. Klicke **Create** und kopiere den langen Schlüssel, der erscheint.

### 4 · Den Schlüssel sicher ablegen

Erstelle in Thonny eine neue Datei `mein_key.txt`, füge deinen Schlüssel ein (**Cmd-V** bzw. **Strg-V**) und speichere sie in deinem Übungs-Ordner. Diese Datei bleibt dort und wird gleich von deinem Programm gelesen.

### 5 · Thonny vorbereiten

Öffne **Thonny** (das blaue Python-Programm — falls noch nicht installiert: → [Werkzeuge-Seite](/werkzeuge/)). Einmalig installierst du das Paket **requests**: **Tools** · **Manage packages** · "requests" suchen · **Install**.

---

## Aufgabe 1 — Hallo, Supercell!

> **Dein Ziel:** Ein erstes Lebenszeichen vom Server bekommen — dein Programm soll deinen Spielernamen und deine Trophäenzahl direkt aus dem Brawl-Stars-Server holen.

### Was du brauchst

Deinen **Spieler-Tag** aus Brawl Stars (steht oben links im Profil, beginnt mit `#` — wir lassen das `#` aber weg).

### Was neu ist

**HTTP-Anfrage**, **API-Schlüssel**, und das erste Lesen aus **JSON**. Klingt viel — ist aber sechs Zeilen Code.

### Dein Programm

Erstelle in Thonny `aufgabe1.py` und schreib hinein:

```python
import requests

API_KEY = open("mein_key.txt").read().strip()
MEIN_TAG = "ABC123"   # <-- hier deinen Tag eintragen (OHNE #)

url = f"https://api.brawlstars.com/v1/players/%23{MEIN_TAG}"
headers = {"Authorization": f"Bearer {API_KEY}"}

antwort = requests.get(url, headers=headers).json()

print(antwort["name"])
print(antwort["trophies"])
```

Drücke **F5** zum Ausführen. Wenn unten dein Spielername und deine Trophäen erscheinen — **du hast gerade dein erstes Mal mit einem echten Internet-Server gesprochen.**

### 🔎 Mini-Forscherfrage

Was passiert, wenn du `print(antwort)` schreibst (ohne den eckigen Klammer-Teil)? Schau dir die Antwort genau an — wie viele verschiedene Dinge findest du dort?

---

## Aufgabe 2 — Mein Profil-Steckbrief

> **Dein Ziel:** Eine schöne Übersicht über dich als Brawl-Stars-Spieler ausgeben — Name, Trophäen, Rekord, Level und Siege.

### Was neu ist

**f-Strings** — die wichtigste Python-Technik, um Text und Variablen zu mischen.

### Dein Programm

Erstelle `aufgabe2.py`, kopiere den Anfang aus Aufgabe 1 hinein, und ersetze die zwei `print`-Zeilen am Ende durch:

```python
print(f"Spieler:      {antwort['name']}")
print(f"Trophäen:     {antwort['trophies']}")
print(f"Rekord:       {antwort['highestTrophies']}")
print(f"Level:        {antwort['expLevel']}")
print(f"3vs3-Siege:   {antwort['3vs3Victories']}")
```

Drücke **F5**. Heraus kommt ein kleiner Steckbrief — nur über dich.

### 🔎 Mini-Forscherfrage

Was bedeutet der Unterschied zwischen `trophies` und `highestTrophies`? Und wenn dein Rekord höher ist als jetzt — was sagt das über dein letztes Spielwochenende?

---

## Aufgabe 3 — Meine Brawler-Liste

> **Dein Ziel:** Alle deine Brawler ausgeben — mit Namen und Trophäen.

### Was neu ist

**Verschachtelte Daten** — eine Liste *in* einem Dictionary, und in jedem Listenelement steckt wieder ein Dictionary. Plus eine **for-Schleife**, die durch die Liste wandert.

### Dein Programm

Erstelle `aufgabe3.py`, wieder den Anfang aus Aufgabe 1 kopieren. Am Ende durch das hier ersetzen:

```python
brawler_liste = antwort["brawlers"]

print(f"Du hast {len(brawler_liste)} Brawler:")
print("-" * 30)

for brawler in brawler_liste:
    print(f"{brawler['name']:15} {brawler['trophies']} Trophäen")
```

**Achtung Einrückung:** Die Zeile nach `for` muss eingerückt sein — bei Python ist die Einrückung Teil des Codes.

> **Hinweis:** Die Brawler-Namen kommen auf **Englisch** aus der API — also `SHELLY`, `COLT`, `BULL` usw., nicht die deutschen Namen aus dem Spiel. Das ist normal.

### 🔎 Mini-Forscherfrage

Welcher deiner Brawler hat die meisten Trophäen? Such ihn **mit den Augen** in der Liste. Und denk schon mal nach: Wie könnte dein **Programm** ihn von selbst finden, ohne dass du hinschaust? (Das machen wir in Aufgabe 4.)
