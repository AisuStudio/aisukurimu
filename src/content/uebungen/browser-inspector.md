---
title: "Aufgabe 5 — Der Browser unter der Lupe"
description: "Schau hinter die Kulissen jeder Webseite — verändere Text und Farben live, und sieh was dein Browser heimlich alles herunterlädt."
slug: browser-inspector
category: hacking
level: 1
ageMin: 10
session: 2
exercise: 5
duration: 30
requiredTools: [browser]
platforms: [mac, windows, linux, browser]
tags: [browser, html, css, devtools, inspector, netzwerk, frontend]
image: /images/AK_EX_0006.jpg
date: 2026-07-02
language: de
---

# Aufgabe 5 — Der Browser unter der Lupe

> **Dein Ziel:** Du schaust hinter die Kulissen einer echten Webseite — veränderst Text und Farben live, und siehst wie viele Dinge dein Browser heimlich herunterlädt, wenn du eine Seite öffnest.

Jede Webseite, die du siehst, besteht aus Code. Dieser Code ist nicht versteckt — er liegt offen vor dir. Hacker und Entwickler schauen ständig hinein. Heute lernst du dasselbe Werkzeug, das sie benutzen: den **Browser-Inspector**.

---

## Was du brauchst

Nur deinen Browser — Chrome, Firefox oder Safari. Kein Login, kein Download, keine Installation.

---

## Schritt 1 — Inspector öffnen

Gehe auf eine beliebige Webseite — zum Beispiel **lab.aisu.studio** oder falls die nicht erreichbar ist: **wikipedia.org**.

Dann:

**Auf dem Mac:**
Drücke `Cmd + Option + I`

**Auf Windows / Linux:**
Drücke `F12` oder `Strg + Shift + I`

**Oder überall:**
Klicke mit der **rechten Maustaste** irgendwo auf die Seite → wähle **„Untersuchen"** *(auf Englisch: „Inspect")*

Ein Seitenpanel öffnet sich mit buntem Code. Das ist der **HTML-Quellcode** der Seite — das Skelett hinter dem Design, das du siehst.

> **Was du siehst:** Tags wie `<h1>`, `<p>`, `<div>` — das sind die Bausteine jeder Webseite. Jeder Tag ist ein Kasten, in dem etwas steckt.

---

## Schritt 2 — Text live verändern

Jetzt veränderst du die Seite — nur für dich, auf deinem Bildschirm.

1. Im Inspector-Panel siehst du den HTML-Code. Suche eine Zeile mit sichtbarem Text — zum Beispiel eine Überschrift.
2. **Doppelklicke** auf das Wort selbst im Code (also auf `Hallo` innerhalb von `<h1>Hallo</h1>`) — nicht auf den Tag `<h1>`.
3. Schreibe etwas anderes — zum Beispiel deinen Namen.
4. Drücke **Enter**.

Die Seite zeigt jetzt deinen Text — auf dem echten Server hat sich nichts verändert. Wenn du die Seite neu lädst, ist alles wieder original.

> **Wow-Moment:** Du hast gerade die Tagesschau-Webseite umgeschrieben. Nur du siehst das — die echte Seite ist unberührt. Das ist der Unterschied zwischen **Frontend** (was du siehst) und **Backend** (was auf dem Server liegt).

---

## Schritt 3 — Farbe ändern (CSS)

Jetzt änderst du das Design:

1. Klicke im Inspector auf ein Element — zum Beispiel eine Überschrift oder einen Button.
2. Auf der rechten Seite (oder unten) erscheint das **Styles-Panel** mit CSS-Regeln.
3. Suche eine Zeile mit `color:` oder `background-color:` und klicke auf den Farbwert.
4. Gib einen anderen Wert ein — zum Beispiel `red`, `#ff0000` oder `blue`.

Die Farbe ändert sich sofort. Probiere auch `font-size: 60px` — die Überschrift wird riesig.

> **Was das ist:** CSS ist die Sprache, die bestimmt wie HTML aussieht — Farben, Abstände, Schriftgrößen. Entwickler schreiben CSS genau so, wie du es gerade ausprobierst.

---

## Schritt 4 — Netzwerk-Tab: Was lädt die Seite heimlich?

Wenn du eine Webseite öffnest, schickt dein Browser viele Anfragen auf einmal — nicht nur für die Seite selbst, sondern für Bilder, Schriften, Tracking-Scripts und mehr.

1. Klicke im Inspector oben auf den Tab **„Netzwerk"** *(auf Englisch: „Network")*
2. **Wichtig:** Lade die Seite jetzt erst neu — `Cmd + R` (Mac) oder `F5` (Windows). Der Network-Tab muss offen sein *bevor* du neu lädst, sonst siehst du nicht alles.
3. Schau dir die Liste an: wie viele Zeilen tauchen auf?

Jede Zeile ist eine Anfrage an einen Server. Klicke auf eine Zeile — du siehst wohin die Anfrage geht und was zurückkommt.

> **Überraschung:** Eine einfache Webseite schickt oft 30–100 Anfragen. Bei großen Seiten (YouTube, Amazon) können es über 200 sein.

---

## 🔎 Mini-Forscherfrage

Gehe auf einen Online-Shop und öffne den Inspector. Suche den Preis eines Produkts im HTML-Code. Doppelklicke und ändere ihn auf `0,01 €`.

- Ändert sich der Preis, den der Shop wirklich berechnet, wenn du kaufst?
- Was sagt das über den Unterschied zwischen **Frontend** (was du siehst) und **Backend** (was der Server weiß)?

Das ist keine Lücke — das ist Absicht. Und es zeigt: **Alles, was nur im Browser existiert, ist kein echter Wert.**
