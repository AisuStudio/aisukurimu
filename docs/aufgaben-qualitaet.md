# Aufgaben-Qualitätsprofil — aisukurimu

Dieses Dokument ist der Maßstab für alle Übungen und Rätsel auf aisukurimu.
Vor dem Veröffentlichen jede Aufgabe gegen diese Checkliste prüfen.

---

## Checkliste

### Ziel & Kontext

- [ ] Das Ziel ist in einem Satz beschreibbar: "Am Ende siehst / hörst / tust du X"
- [ ] Der erste Absatz erklärt *warum* das cool oder nützlich ist — nicht nur was
- [ ] Der Kontext ist greifbar (ein Spiel, eine Webseite, der eigene Rechner — nichts Abstraktes)

### Schritte

- [ ] Jeder Schritt = eine Aktion + ein direkt sichtbares Ergebnis
- [ ] Kein Begriff taucht auf, bevor er eingeführt und erklärt wurde
- [ ] Mac- und Windows-Varianten sind beide vollständig und getestet
- [ ] Alle Menünamen, Button-Labels und Tastenkürzel stimmen mit dem aktuellen Stand der Tools überein
- [ ] Fehler-Hinweise dort, wo Kinder erfahrungsgemäß stecken bleiben (falsche Einrückung, falscher Tag, Groß/Kleinschreibung)

### Keine Gedankensprünge

- [ ] Maximale kognitive Distanz zwischen "was ich tippe" und "was ich sehe" = direkt und sofort
- [ ] Keine Mathe-Umrechnungen ohne die Formel direkt darunter (z.B. Bytes → GB: `÷ 1.073.741.824`)
- [ ] Keine externen Dienste mit Login, IP-Eingabe oder wechselnder UI — oder wenn doch: expliziter Hinweis dass die UI auf Englisch sein kann
- [ ] Kein Schritt setzt voraus, dass ein vorheriger Schritt aus einer *anderen* Aufgabe noch im Arbeitsverzeichnis liegt (oder: klarer Hinweis)

### 10-Jährigen-Test

- [ ] Ein Kind mit Null Vorkenntnissen kann Schritt 1 selbst starten
- [ ] Es gibt einen sichtbaren "Wow-Moment" spätestens im zweiten Schritt
- [ ] Wenn ein Kind beim ersten Fehler stecken bleibt — ist der häufigste Fehler bereits als Hinweis beschrieben?
- [ ] Die Mini-Forscherfrage am Ende ist beantwortbar ohne weiteres Vorwissen — sie regt an, nicht ab

---

## Typische Fallen

| Falle | Beispiel | Fix |
|-------|----------|-----|
| Externe UI ändert sich | App Store Labels auf Englisch | Beide Sprachen nennen, oder Aufgabe umschreiben |
| Live-API als Kernschritt | Brawl Stars Developer Portal | Als "Vorbereitung mit Lehrer" markieren |
| Mathe ohne Formel | `hw.memsize` in Bytes → GB | Formel direkt darunter: `÷ 1.073.741.824` |
| Vorwissen aus Folge-Aufgabe | "kopiere den Anfang aus Aufgabe 3" | Startcode nochmal einbauen oder Link auf Startdatei |
| Zu langer erster Schritt | 5 Unter-Schritte vor dem ersten sichtbaren Ergebnis | Aufbrechen: ein Ergebnis pro Abschnitt |

---

## Prompt-Template für neue Aufgaben

Beim Schreiben einer neuen Aufgabe diesen Prompt verwenden (z.B. mit Claude):

```
Schreibe eine aisukurimu-Aufgabe für Kinder ab 10 Jahren.

Thema: [THEMA]
Kategorie: hacking | coding | making | systemiker
Vorwissen: [was das Kind schon kennt]
Ziel: [was das Kind am Ende kann / gesehen hat]
Tools: [Terminal / Browser / Thonny / etc.]

Regeln:
- Jeder Schritt hat ein direkt sichtbares Ergebnis
- Kein Begriff ohne kurze Erklärung beim ersten Auftauchen
- Wow-Moment spätestens im zweiten Schritt
- Mac + Windows Variante wo nötig
- Am Ende: eine Mini-Forscherfrage die neugierig macht, nicht überfordert
- Kein Schritt erfordert Login oder externe Abhängigkeit — oder wenn doch: als "Vorbereitung mit Lehrer" kennzeichnen
- Sprache: einfaches Deutsch, du-Form, keine Fachbegriffe ohne Erklärung
- Nach dem Schreiben: Aufgabe einmal selbst durchführen und Zeit stoppen
```

---

## Bewertungsraster (nach Fertigstellung)

| Kriterium | 0 — nicht erfüllt | 1 — teilweise | 2 — vollständig |
|-----------|-------------------|---------------|-----------------|
| Klares Ziel | | | |
| Wow-Moment vorhanden | | | |
| Keine externen Deps | | | |
| Kein Gedankensprung | | | |
| 10-Jährigen-Test bestanden | | | |
| Mac + Windows getestet | | | |

**Min. 10 von 12 Punkten** vor Veröffentlichung.
