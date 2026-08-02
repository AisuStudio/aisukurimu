# 1x pro Sekunde, solange der Lauf aktiv ist (ak_state == 1)
execute unless score #game ak_state matches 1 run return 0

# Eine Sekunde abziehen
scoreboard players remove #game ak_time 1

# Bossbar aktualisieren
execute store result bossbar aisu_escape:countdown value run scoreboard players get #game ak_time

# Restsekunden in der Actionbar zeigen
title @a actionbar [{"text":"Countdown: ","color":"gray"},{"score":{"name":"#game","objective":"ak_time"},"color":"red"},{"text":" s","color":"gray"}]

# Druck-Puls: unter 60 s jede Sekunde ein hoher Warnton
execute if score #game ak_time matches 1..60 run playsound minecraft:block.note_block.pling master @a ~ ~ ~ 0.6 2
# Im Bereich 61..300 nur alle 5 Sekunden ein dezenter Tick
execute if score #game ak_time matches 61..300 run function aisu_escape:pulse_mid

# Zeit abgelaufen?
execute if score #game ak_time matches ..0 run function aisu_escape:lose

# Naechste Sekunde einplanen, solange noch aktiv
execute if score #game ak_state matches 1 run schedule function aisu_escape:countdown 1s replace
