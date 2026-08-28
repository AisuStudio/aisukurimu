# Countdown auf dem Atoll — Setup (laeuft bei jedem /reload und beim Weltstart)
# --------------------------------------------------------------
# Scoreboard-Objectives anlegen (Fehler still ignorieren wenn schon da)
scoreboard objectives add ak_time dummy {"text":"Zeit"}
scoreboard objectives add ak_state dummy
scoreboard objectives add ak_stage dummy
scoreboard objectives add ak_seen dummy
scoreboard objectives add ak_route trigger {"text":"Route"}
scoreboard objectives add ak_dial trigger {"text":"Chiffrier-Rad"}
scoreboard objectives add ak_alarm trigger {"text":"Alarm-Code"}
scoreboard objectives add ak_cam trigger {"text":"Kamera-PIN"}
scoreboard objectives add ak_log trigger {"text":"Freie Minute"}

# Globaler Zustand liegt auf dem Fake-Spieler #game
#   ak_state: 0 = bereit, 1 = laeuft, 2 = entkommen, 3 = Zeit abgelaufen
#   ak_stage: 1 = Caesar, 2 = Alarm, 3 = Kamera, 4 = Log, 9 = geloest
scoreboard players set #game ak_state 0
scoreboard players set #game ak_stage 0

# Konstante fuer die Modulo-Rechnung (Puls alle 5 s)
scoreboard players set #five ak_time 5

# Bossbar fuer den Countdown
bossbar add aisu_escape:countdown {"text":"Countdown"}
bossbar set aisu_escape:countdown color red
bossbar set aisu_escape:countdown style notched_10
bossbar set aisu_escape:countdown visible false

# Menue anzeigen (falls schon Spieler da sind; neue Spieler begruesst der tick)
function aisu_escape:menu
