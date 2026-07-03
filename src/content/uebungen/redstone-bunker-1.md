---
title: "Redstone-Bunker — Die Geheimtür"
description: "Bau in Minecraft eine versteckte Eisentür, die sich per Hebel öffnet — dein erstes echtes Sicherheitssystem."
slug: redstone-bunker-1
category: hacking
subcategory: systeme
level: 1
ageMin: 8
duration: 15
platforms: [minecraft]
tags: [minecraft, redstone, systeme, schaltkreise, anfaenger]
image: /images/AK_EX_0012.jpg
date: 2026-07-03
language: de
---

# Redstone-Bunker — Die Geheimtür

> **Dein Ziel:** Bau eine geheime Untergrundbase mit einer Tür, die sich von außen nicht öffnen lässt — außer du weißt wo der versteckte Schalter ist.

## Was du brauchst

Du brauchst Minecraft (Java Edition oder Bedrock) und diese Blöcke im Inventar:

| Block | Anzahl | Wozu |
|---|---|---|
| Beliebige Vollblöcke (z.B. Stein) | ~30 | Wände und Boden |
| **Eisentür** | 1 | Die Geheimtür |
| **Hebel** | 1 | Dein Schalter |
| **Redstone-Staub** | 6 | Die Leitung |
| Gemälde | 1 | Tarnung für den Hebel |

Im Kreativmodus kannst du alle Blöcke kostenlos aus dem Inventar holen (Taste **E**).

## Was neu ist

**Redstone** ist Minecrafts Elektrizität. Wie in einer echten Schaltkreis-Zeichnung gilt:

- **Hebel** = Schalter (gibt Signal: ein oder aus)
- **Redstone-Staub** = Kabel (leitet das Signal weiter)
- **Eisentür** = Gerät (reagiert auf das Signal)

Wenn du den Hebel umlegt, fließt ein Signal durch den Staub direkt in die Tür. Die Tür öffnet sich. Hebel zurück — Tür zu.

## Schritt 1 — Bau die Kammer

Bau eine kleine Kammer aus Steinblöcken: ca. **5 × 5 × 3 Blöcke** (Breite × Tiefe × Höhe). Eine Seite lässt du als Eingang offen — dort kommt später die Eisentür rein.

```
Draufsicht von oben:
 █ █ █ █ █
 █         █
 █         █
 █         █
 █ █ [  ] █   ← Eingang (2 Blöcke hoch)
```

## Schritt 2 — Setze die Eisentür

Klicke mit der **Eisentür** in der Hand auf den Boden des Eingangs. Die Tür braucht **2 Blöcke Höhe** — sie setzt sich automatisch als Doppelblock.

> Eisentüren lassen sich nicht per Hand öffnen — nur durch ein Redstone-Signal. Das ist der Punkt.

## Schritt 3 — Verlege die Leitung

Geh auf die **Außenseite** der Kammer (wo der Feind stehen würde). Leg vom Boden neben der Tür aus **Redstone-Staub** in einer Linie weg — ca. 4–5 Blöcke lang, dann um die Ecke.

```
Draufsicht:
 [Tür] · · · ·
               ·
               [hier kommt der Hebel]
```

Redstone-Staub leitet maximal **15 Blöcke** weit. Danach brauchst du einen Verstärker (Redstone-Repeater) — für diese Aufgabe reichen 5 Blöcke locker.

## Schritt 4 — Verstecke den Hebel

Platziere den **Hebel** am Ende der Leitung — zum Beispiel hinter einem Busch, einer Fackel oder einer Wand-Ecke. Am besten an einem Ort, den nur du kennst.

Dann hänge ein **Gemälde** direkt daneben an die Wand, damit die Leitung verdeckt wird.

Leg den Hebel um — die Tür öffnet sich.

## Schritt 5 — Teste dein System

Checkliste:
- [ ] Tür geht auf wenn Hebel umgelegt wird
- [ ] Tür geht zu wenn Hebel zurückgelegt wird
- [ ] Von außen nicht sofort erkennbar wo der Hebel ist
- [ ] Redstone-Leitung vollständig verlegt (keine Lücken)

Falls die Tür sich nicht öffnet: Prüfe ob der Redstone-Staub **lückenlos** von Hebel bis Tür verläuft. Selbst eine fehlende Ecke unterbricht das Signal.

## Was du gerade gebaut hast

Ein echter Grundschaltkreis: **Input → Leitung → Output**.

In echten Gebäuden funktioniert das genauso: Du hältst deine Schlüsselkarte an den Leser (Hebel), ein Signal geht zum Türcomputer (Leitung), der elektronische Riegel öffnet sich (Eisentür).

Dein Bunker hat jetzt eine Geheimtür. In [Stufe 2](/uebungen/redstone-bunker-2/) fügen wir eine Alarmanlage hinzu — für den Fall, dass jemand doch den Eingang findet.

## 🔎 Mini-Forscherfrage

Was passiert wenn du den Hebel auf einem **Block oben drauf** befestigst statt an der Wand? Funktioniert die Leitung noch? Probiere verschiedene Positionen aus — Redstone-Staub leitet nicht nur horizontal.
