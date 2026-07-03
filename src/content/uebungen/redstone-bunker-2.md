---
title: "Redstone-Bunker — Das Alarmsystem"
description: "Erweitere deinen Bunker um eine Alarmanlage: Eindringlinge lösen einen Notenblock-Alarm aus — aber du kommst trotzdem rein."
slug: redstone-bunker-2
category: hacking
subcategory: systeme
level: 2
ageMin: 11
duration: 20
platforms: [minecraft]
tags: [minecraft, redstone, systeme, logikgatter, not-gate, entdecker]
image: /images/AK_EX_BUNKER2.jpg
date: 2026-07-03
language: de
---

# Redstone-Bunker — Das Alarmsystem

> **Dein Ziel:** Jemand hat deinen Eingang entdeckt. Bau eine Alarmanlage, die sofort losgeht wenn jemand die Tür betritt — aber dich selbst nicht stört.

In [Stufe 1](/uebungen/redstone-bunker-1/) hast du eine Geheimtür mit Hebel gebaut. Jetzt fügen wir drei Dinge hinzu: eine **Druckplatte**, einen **Alarm** und einen **Deaktivierungsschalter** nur für dich.

## Was du zusätzlich brauchst

| Block | Anzahl | Wozu |
|---|---|---|
| **Steindruckplatte** | 1 | Sensor: erkennt Eindringlinge |
| **Notenblock** | 1–3 | Alarm-Sound |
| **Redstone-Fackel** | 1 | NOT-Gate (dreht Signal um) |
| **Redstone-Lampe** | 1 | Statusanzeige: Alarm aktiv |
| Redstone-Staub | ~10 | Neue Leitungen |
| Zweiter Hebel | 1 | Alarm-Deaktivierung für dich |

## Was neu ist

**Parallele Leitungen.** In Stufe 1 gab es nur eine Leitung: Hebel → Tür. Jetzt verzweigt sich das Signal. Aus einem Eingang werden gleichzeitig **zwei Ausgänge**: der Notenblock und die Lampe gehen beide an.

**Das NOT-Gate.** Eine **Redstone-Fackel** kehrt ein Signal um: Wenn Strom ankommt, geht die Fackel aus. Wenn kein Strom ankommt, leuchtet sie. Das klingt seltsam — ist aber unglaublich nützlich. Damit bauen wir: "Alarm wenn NICHT du es bist."

## Schritt 1 — Druckplatte vor dem Eingang

Setze eine **Steindruckplatte** direkt auf den Bodenblock vor der Eisentür (außen). Sobald jemand darauf tritt, sendet sie ein Redstone-Signal.

> Steindruckplatten reagieren nur auf **Spieler und Mobs** — nicht auf Items oder Wasser. Holzdruckplatten reagieren auf alles.

## Schritt 2 — Leitung vom Sensor zum Alarm

Verlege Redstone-Staub von der Druckplatte zu deinem **Notenblock**. Der Notenblock kann an die Wand direkt neben dem Eingang — du willst den Alarm hören, egal wo du bist.

Teste: Tritt auf die Platte. Der Notenblock sollte einen Ton erzeugen.

## Schritt 3 — Parallele Ausgabe: Lampe dazu

Leite vom selben Redstone-Staub (irgendwo in der Mitte der Leitung) einen **Abzweig** zur **Redstone-Lampe** ab. Redstone-Staub verzweigt automatisch wenn du ihn in eine Richtung baust — du musst nichts weiter tun.

Wenn du jetzt auf die Druckplatte trittst, leuchten **Notenblock und Lampe gleichzeitig** auf. Ein Signal — zwei Geräte.

## Schritt 4 — Das NOT-Gate: Alarm deaktivieren

Hier wird es interessant. Du willst: **Alarm aus, wenn du bewusst deaktivierst**.

Baue das so:

1. Setze einen **zweiten Hebel** an einer versteckten Stelle innen in der Kammer.
2. Verlege Redstone von diesem Hebel zu einer **Redstone-Fackel** auf dem Block direkt neben der Notenblock-Leitung.
3. Wenn der Hebel ein gibt → Strom fließt zur Fackel → Fackel erlischt → Fackel-Signal unterbricht die Alarm-Leitung.

```
Druckplatte → [Leitung] → Notenblock
                    ↓
               Redstone-Lampe

Deaktivierungs-Hebel → Redstone-Fackel → [blockiert Alarm-Leitung]
```

Teste:
- Hebel aus → Druckplatte → Alarm ertönt ✓
- Hebel ein (du deaktivierst) → Druckplatte → kein Alarm ✓
- Dein Geheim-Hebel aus Stufe 1 funktioniert weiterhin unabhängig ✓

## Schritt 5 — Alles zusammen testen

Checkliste:
- [ ] Druckplatte löst Notenblock aus
- [ ] Redstone-Lampe leuchtet gleichzeitig
- [ ] Deaktivierungs-Hebel schaltet den Alarm stumm
- [ ] Geheimtür aus Stufe 1 funktioniert noch
- [ ] Druckplatte innen (wo du stehst) löst keinen Alarm aus

Falls die Lampe flackert: Redstone-Leitungen dürfen sich nicht ungewollt kreuzen. Baue Abzweige immer auf dem selben Höhenniveau.

## Was du gerade gebaut hast

Ein **Zwei-Zonen-Sicherheitssystem**:
- Zone 1 (außen): Sensor → Alarm
- Zone 2 (innen): Du kontrollierst, wann der Alarm stumm ist

In echten Einbruchmeldeanlagen gibt es dasselbe Prinzip: eine kurze Zeit nach dem Einschalten kannst du einen PIN eingeben (= dein Deaktivierungs-Hebel) bevor der Alarm losgeht.

In [Stufe 3](/uebungen/redstone-bunker-3/) machen wir das System **automatisch**: Die Ausgänge schließen sich selbst, zählen Sekunden ab und öffnen sich wieder — ohne dass du etwas drücken musst.

## 🔎 Mini-Forscherfrage

Was passiert wenn du **zwei** Druckplatten hintereinander in die Leitung baust — eine draußen, eine drinnen? Kannst du ein System bauen, das nur Alarm schlägt wenn jemand draußen steht, aber **nicht** wenn du drinnen bist und die innere Platte betrittst?
