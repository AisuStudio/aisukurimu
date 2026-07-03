---
title: "Redstone-Bunker — Der automatische Lockdown"
description: "Bau einen Takt-Schaltkreis: Alarm → automatische Verriegelung für 5 Sekunden → automatischer Reset. Kein Tastendruck nötig."
slug: redstone-bunker-3
category: hacking
subcategory: systeme
level: 3
ageMin: 13
duration: 30
platforms: [minecraft]
tags: [minecraft, redstone, systeme, taktschaltkreis, clock, kolben, detektiv]
image: /images/AK_EX_0012.jpg
date: 2026-07-03
language: de
---

# Redstone-Bunker — Der automatische Lockdown

> **Dein Ziel:** Der Alarm reicht nicht mehr. Wenn jemand eindringt, soll sich der Bunker **automatisch verriegeln** — für genau 5 Sekunden, dann öffnet er sich selbst wieder. Kein Tastendruck. Kein manuelles Eingreifen.

In [Stufe 1](/uebungen/redstone-bunker-1/) hast du eine Geheimtür gebaut. In [Stufe 2](/uebungen/redstone-bunker-2/) kam der Alarm dazu. Jetzt bauen wir das Gehirn des Systems: einen **Takt-Schaltkreis** — Minecrafts Version einer Uhr.

## Was du zusätzlich brauchst

| Block | Anzahl | Wozu |
|---|---|---|
| **Klebriger Kolben** (Sticky Piston) | 4 | Sperrt Fluchtwege automatisch |
| **Redstone-Verstärker** (Repeater) | 5 | Baut die Uhr + Verzögerung |
| Redstone-Staub | ~20 | Neue Leitungen |
| Steinblöcke | 4 | Werden von Kolben verschoben |
| Hebel (Master) | 1 | Notfall-Override |

## Was neu ist

**Der Takt-Schaltkreis (Clock Circuit).** Stell dir vor du willst, dass etwas genau 5 Sekunden passiert — und dann von alleine aufhört. Ohne Uhr, ohne Timer-App. Nur mit Redstone.

Das geht so: Ein **Redstone-Verstärker** (Repeater) kann ein Signal um bis zu **4 Ticks** verzögern. Ein Tick = 0,1 Sekunden. 5 Verstärker à 4 Ticks = 2 Sekunden Verzögerung. Wenn du 5 davon hintereinander in eine **Schleife** legst, hast du eine einfache Uhr.

Für den **Einmal-Auslöser** (Monostabiler Schaltkreis) sorgt der Trick, dass du die Schleife nur einmal durchlaufen lässt — dann stoppt sie sich selbst.

## Schritt 1 — Klebriger Kolben als Sperre

Setze **4 klebrige Kolben** in den Fluchttunnel deines Bunkers — je 2 auf jeder Seite, direkt gegenüber. Hinter jeden Kolben kommt ein Steinblock (den der Kolben greifen soll).

```
[Kolben]→[Stein]    [Stein]←[Kolben]
    ↑ Signal            Signal ↑
```

Wenn die Kolben aktiviert werden, schieben sie die Steinblöcke in die Mitte — der Durchgang ist versperrt. Wenn das Signal weg ist, ziehen sie die Blöcke zurück.

Teste kurz manuell: Lege Redstone-Staub direkt zu einem Kolben und verbinde ihn mit einem Hebel. Kolben rein, Kolben raus. Dann Hebel wieder entfernen.

## Schritt 2 — Der Verzögerungs-Pfad

Statt die Kolben direkt mit der Druckplatte zu verbinden, bauen wir dazwischen eine **Verstärker-Kette**. Jeder Verstärker hält das Signal kurz fest bevor er es weitergibt.

Baue eine Reihe von **5 Redstone-Verstärkern** hintereinander, alle in dieselbe Richtung zeigend. Stelle jeden auf **4 Ticks** (rechtsklicken bis der Balken ganz rechts ist).

```
[Druckplatte] → [R4] → [R4] → [R4] → [R4] → [R4] → [Kolben]
```

Wenn die Druckplatte ausgelöst wird, braucht das Signal jetzt **2 Sekunden** bis es bei den Kolben ankommt. Die Kolben bleiben so lange aktiv wie das Druckplatten-Signal anhält.

## Schritt 3 — Der Selbst-Reset

Jetzt der schwierigste Teil: Das System soll sich **nach 5 Sekunden von selbst zurücksetzen** — auch wenn noch jemand auf der Druckplatte steht.

Baue das so:

1. Setze nach dem letzten Verstärker einen **Abzweig**: einen Redstone-Pfad der **zurück** zur Startleitung führt — aber durch eine **Redstone-Fackel** geleitet wird. Die Fackel dreht das Signal um.
2. Diese umgekehrte Rückkopplung unterbricht die ursprüngliche Druckplatten-Leitung nach einem Durchlauf.

```
[Druckplatte]─────────────→[Verstärker-Kette]→[Kolben schließen]
       ↑                              │
       └──[Redstone-Fackel]←──────────┘
          (dreht Signal um, unterbricht Eingang)
```

Ergebnis: Die Druckplatte löst aus → Kolben schließen → nach 2–3 Sekunden kommt das umgekehrte Signal zurück → Kolben öffnen → System steht bereit für den nächsten Auslöser.

> Falls die Schaltung nicht stoppt und dauerhaft "flimmert": Füge einen weiteren Verstärker auf 4 Ticks in den Rückkopplungs-Zweig ein. Das gibt dem System Zeit, sich zu stabilisieren.

## Schritt 4 — Master-Override

Für den Notfall: Setze einen **Hebel** direkt in die Kolben-Leitung. Wenn du ihn umlegt, öffnen sich alle Sperren sofort — egal was der Taktschaltkreis gerade macht.

Verstecke diesen Hebel an einer Stelle, die nur du kennst. Im Ernstfall willst du ihn schnell finden.

## Schritt 5 — Alles zusammen testen

Checkliste:
- [ ] Druckplatte aktiviert → Kolben schließen nach kurzer Verzögerung
- [ ] Kolben öffnen sich nach ~5 Sekunden automatisch
- [ ] System löst beim nächsten Betreten wieder aus (kein manuelles Reset nötig)
- [ ] Master-Override öffnet sofort
- [ ] Geheimtür aus Stufe 1 und Alarm aus Stufe 2 funktionieren weiterhin

## Dein komplettes System im Überblick

```
STUFE 1 — Geheimtür
  Hebel (versteckt) → Redstone-Leitung → Eisentür

STUFE 2 — Alarm
  Druckplatte → Notenblock + Redstone-Lampe
  Deaktivierungs-Hebel → NOT-Gate → stummt Alarm

STUFE 3 — Automatischer Lockdown
  Druckplatte → Verstärker-Kette → Kolben-Sperre
  Rückkopplungs-Pfad → automatischer Reset nach ~5s
  Master-Override → sofortiges Öffnen
```

## Was du gerade gebaut hast

Du hast ein **Intrusion Detection System (IDS)** gebaut — dasselbe Prinzip, das in echten Rechenzentren und Serverräumen läuft:

1. **Erkennen** — Druckplatte = Sensor
2. **Melden** — Notenblock + Lampe = Alert
3. **Sperren** — Kolben = automatisches Lockdown
4. **Zurücksetzen** — Taktschaltkreis = automatischer Reset

Der Taktschaltkreis, den du gebaut hast, ist im Prinzip dasselbe wie die Takt-Frequenz einer echten CPU. Auch Prozessoren arbeiten mit Takt-Zyklen — nur mit Milliarden von Ticks pro Sekunde statt fünf.

## 🔎 Mini-Forscherfrage

Kannst du die Anzahl der Verstärker erhöhen oder verringern, um die Lockdown-Zeit zu verändern? Wie viele Verstärker brauchst du für genau **10 Sekunden** Sperrzeit? Was passiert wenn du die Verstärker auf **1 Tick** statt 4 stellst?
