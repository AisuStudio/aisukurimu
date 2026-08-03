# Countdown starten (wird von den route/*-Functions aufgerufen)
scoreboard players set #game ak_state 1
scoreboard players set #game ak_stage 1
scoreboard players set @a ak_secret 0

# Bossbar aufsetzen: max + aktueller Wert = Startzeit
execute store result bossbar aisu_escape:countdown max   run scoreboard players get #game ak_time
execute store result bossbar aisu_escape:countdown value run scoreboard players get #game ak_time
bossbar set aisu_escape:countdown players @a
bossbar set aisu_escape:countdown visible true

# Chiffrier-Rad freischalten, damit /trigger ak_dial funktioniert
scoreboard players enable @a ak_dial

# Funkspruch (Caesar) an alle geben
function aisu_escape:puzzle/give_radio

# Story-Einstieg
title @a times 10 40 20
title @a title {"text":"Countdown auf dem Atoll","color":"red"}
title @a subtitle {"text":"Entkomme, bevor der Test startet.","color":"gray"}
tellraw @a {"text":"[Funk] Das letzte Boot legt ab, wenn du den Zugangscode entschluesselst.","color":"aqua"}

# Schleifen starten
schedule function aisu_escape:countdown 1s replace
function aisu_escape:drone
