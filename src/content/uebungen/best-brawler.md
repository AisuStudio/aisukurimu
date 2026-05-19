---
title: "Aufgabe 4 — Mein bester Brawler"
description: "Finde mit if-Bedingung und Merker-Variable deinen Brawler mit den meisten Trophäen."
slug: best-brawler
category: coding
subcategory: brawlstars-api
level: 2
ageMin: 10
session: 2
exercise: 4
duration: 25
requiredTools: [thonny, terminal]
platforms: [mac, linux, windows]
tags: [python, api, json, for-loop, conditional]
date: 2026-05-18
language: de
---

# Aufgabe 4 — Mein bester Brawler

> **Dein Ziel:** Finde mit deinem Programm den Brawler mit den meisten Trophäen — und gib seinen Namen plus die Trophäenzahl aus.

## Was du brauchst

Den Code aus **Aufgabe 3** als Startpunkt — du hast ja schon eine Liste deiner Brawler. Jetzt soll dein Programm da hineinschauen und sich den besten merken.

## Was neu ist

Eine **if-Bedingung** — also ein „falls das passt, dann …". Und eine **Merker-Variable**, die sich während der Schleife daran erinnert, wer bisher der Beste war.

## Dein Programm

```python
import requests

API_KEY = open("mein_key.txt").read().strip()
MEIN_TAG = "ABC123"   # <-- hier deinen Tag eintragen (OHNE #)

url = f"https://api.brawlstars.com/v1/players/%23{MEIN_TAG}"
headers = {"Authorization": f"Bearer {API_KEY}"}
antwort = requests.get(url, headers=headers).json()

brawler_liste = antwort["brawlers"]

# Hier merken wir uns den besten
bester_name = ""
beste_trophaeen = 0

# Wir gehen alle Brawler durch und vergleichen
for brawler in brawler_liste:
    if brawler["trophies"] > beste_trophaeen:
        beste_trophaeen = brawler["trophies"]
        bester_name = brawler["name"]

print(f"Mein bester Brawler: {bester_name}")
print(f"Er hat {beste_trophaeen} Trophaeen!")
```

## Was du machst

1. Erstelle in Thonny eine neue Datei `aufgabe4.py`.
2. Tippe den Code oben ab — oder kopiere ihn vorsichtig (Achtung Einrückungen!).
3. Setze deinen eigenen Spieler-Tag bei `MEIN_TAG` ein.
4. Drücke **F5**.
5. Vergleiche das Ergebnis mit der Liste aus Aufgabe 3 — stimmt es?

## Achtung bei Python

Die Zeilen *nach* dem `for` und `if` sind **eingerückt**. Bei Python ist diese Einrückung Teil des Codes — sie sagt: „das gehört zur Schleife / zur Bedingung". Wenn du sie wegläßt, versteht Python das Programm anders oder gar nicht.

## 🔎 Mini-Forscherfrage

Was passiert, wenn du in der Schleife versehentlich `>` durch `<` ersetzt? Probier es aus — wie heißt dein Programm jetzt? Und: Wenn zwei Brawler gleich viele Trophäen haben, welchen findet dein Programm?
