# Countdown auf dem Atoll — Setup (laeuft bei jedem /reload)
# --------------------------------------------------------------
# Scoreboard-Objectives anlegen (Fehler still ignorieren wenn schon da)
scoreboard objectives add ak_time     dummy   {"text":"Zeit"}
scoreboard objectives add ak_state    dummy
scoreboard objectives add ak_stage    dummy
scoreboard objectives add ak_dial     trigger {"text":"Chiffrier-Rad"}
scoreboard objectives add ak_alarm    trigger {"text":"Alarm-Code"}

# Globaler Zustand liegt auf dem Fake-Spieler #game
#   ak_state: 0 = bereit, 1 = laeuft, 2 = entkommen, 3 = Zeit abgelaufen
#   ak_stage: 1 = Caesar aktiv, 2 = Alarm aktiv, 9 = geloest
scoreboard players set #game ak_state 0
scoreboard players set #game ak_stage 0

# Konstante fuer die Modulo-Rechnung (Puls alle 5 s)
scoreboard players set #five ak_time 5

# Bossbar fuer den Countdown
bossbar add aisu_escape:countdown {"text":"Countdown"}
bossbar set aisu_escape:countdown color red
bossbar set aisu_escape:countdown style notched_10
bossbar set aisu_escape:countdown visible false

# Begruessung
tellraw @a {"text":"[Atoll] Datapack geladen.","color":"aqua"}
tellraw @a {"text":"Waehle eine Route und starte:","color":"gray"}
tellraw @a ["  ",{"text":"[ Zaun – leicht ]","color":"green","clickEvent":{"action":"run_command","value":"/function aisu_escape:route/easy"},"hoverEvent":{"action":"show_text","contents":"15 Minuten Zeit"}},"  ",{"text":"[ Kanalisation – mittel ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function aisu_escape:route/medium"},"hoverEvent":{"action":"show_text","contents":"10 Minuten Zeit"}},"  ",{"text":"[ Hauptgebaeude – schwer ]","color":"red","clickEvent":{"action":"run_command","value":"/function aisu_escape:route/hard"},"hoverEvent":{"action":"show_text","contents":"5 Minuten Zeit"}}]
