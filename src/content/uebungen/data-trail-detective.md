---
title: "Aufgabe 6 — Datenspuren-Detektiv"
description: "Werde Detektiv für deine eigenen Daten — schreib ein Datenspuren-Dossier aus dem App Store."
slug: data-trail-detective
category: hacking
subcategory: security-literacy
level: 2
ageMin: 10
session: 2
exercise: 6
duration: 45
requiredTools: [thonny, browser]
platforms: [mac, windows]
tags: [python, dictionary, file-write, privacy, security-literacy, app-store]
image: /images/AK_EX_0006.png
date: 2026-05-18
language: de
---

# Datenspuren-Detektiv

> **Dein Ziel:** Werde Detektiv für deine eigenen Daten. Finde heraus, was drei deiner Lieblings-Apps über dich sammeln, und schreib daraus ein „Datenspuren-Dossier" als Datei.

## Was du brauchst

Einen Browser, Zugang zum **App Store** (oder zu **apps.apple.com** im Browser), und Thonny. Du wirst *kein* Internet aus Python heraus brauchen — nur deine Augen und deine Lesefähigkeit.

## Was neu ist

Zwei neue Werkzeuge:

**Dictionary** — eine neue Datenstruktur. Statt einer einfachen Liste speicherst du Paare: *Name → Wert*. Zum Beispiel: *App-Name → Liste der gesammelten Daten*.

**Datei zum Schreiben öffnen** — bisher haben wir Dateien nur *gelesen* (`mein_key.txt`). Heute lassen wir Python eine Datei *schreiben*. Der Modus heißt `"w"` wie *write*.

## Schritt 1 — Detektivarbeit im App Store

Such dir drei Apps aus, die du regelmäßig nutzt — z. B. **Brawl Stars**, **TikTok**, **WhatsApp**, **YouTube**, **Roblox**.

Für jede App: Gehe auf **apps.apple.com**, suche die App, scrolle runter bis zum Abschnitt **„App-Datenschutz"**. Apple zeigt dort drei Kategorien:

- *Daten zur Nachverfolgung anderer Apps oder Webseiten*
- *Mit dir verknüpfte Daten*
- *Nicht mit dir verknüpfte Daten*

Wir konzentrieren uns auf **„Mit dir verknüpfte Daten"** — das ist die spannendste Kategorie. Notiere für jede App, welche Datentypen dort auftauchen (z. B. Standort, Käufe, Kontakte, Identifier, Suchverlauf …).

## Schritt 2 — Deine Funde in Python eintragen

Erstelle in Thonny `aufgabe6.py` und schreib hinein (ersetze die Beispiel-Daten durch *deine* Funde):

```python
# Datenspuren-Detektiv — meine Funde aus dem App Store

apps = {
    "Brawl Stars": ["Standort", "Käufe", "Identifier", "Nutzungsdaten"],
    "TikTok":      ["Standort", "Kontakte", "Suchverlauf",
                    "Käufe", "Identifier", "Nutzungsdaten"],
    "WhatsApp":    ["Käufe", "Standort", "Kontakte", "Identifier"],
}

print(apps)
```

Drücke **F5**. Du siehst alle deine Funde zusammen auf einen Blick. Das ist ein **Dictionary**: jede App ist ein *Schlüssel*, und ihr *Wert* ist eine Liste mit den Datentypen.

## Schritt 3 — Ein Dossier schreiben

Jetzt soll Python aus deinen Daten ein hübsches Dossier erzeugen — und in eine Datei speichern, die du später öffnen, drucken oder Freunden zeigen kannst.

Ergänze dein Skript unten so:

```python
# Datei zum Schreiben öffnen (Modus "w" wie write)
datei = open("datenspuren.txt", "w")

datei.write("MEIN DATENSPUREN-DOSSIER\n")
datei.write("=" * 40 + "\n\n")

# Für jede App: Name und Daten auflisten
for app_name in apps:
    daten = apps[app_name]
    datei.write(f"{app_name} sammelt:\n")
    for d in daten:
        datei.write(f"  - {d}\n")
    datei.write(f"  ({len(daten)} verschiedene Datentypen)\n\n")

datei.close()
print("Fertig! Schau dir 'datenspuren.txt' an.")
```

Drücke **F5**. Im Übungs-Ordner ist jetzt eine neue Datei `datenspuren.txt` — öffne sie und sieh, wer was über dich weiß.

## Achtung beim Modus „w"

Der Modus `"w"` ist mächtig — und gefährlich. Wenn die Datei schon existiert, wird sie **komplett überschrieben**. Wenn du etwas *anhängen* willst, ohne das Alte zu zerstören, benutzt du `"a"` wie *append*. (Genau das machen wir später beim Verlauf-Tracking.)

## 🔎 Mini-Forscherfrage

Schau dir `datenspuren.txt` in Ruhe an. Welche Daten werden von **allen drei** deiner Apps gesammelt? Diese gemeinsame Schnittmenge ist sozusagen deine **„unsichtbare digitale Identität"** — egal welche dieser Apps du benutzt, diese Daten fließen immer weg. Was würde es bedeuten, wenn jemand all diese Daten auf einmal in die Hand bekäme?
