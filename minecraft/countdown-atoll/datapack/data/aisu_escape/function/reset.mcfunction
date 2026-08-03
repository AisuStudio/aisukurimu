# Alles auf Anfang — zurueck ins Routen-Auswahlmenue.
scoreboard players set #game ak_state 0
scoreboard players set #game ak_stage 0
scoreboard players set #game ak_time 0
scoreboard players set @a ak_dial 0
scoreboard players set @a ak_alarm 0
scoreboard players set @a ak_cam 0
scoreboard players set @a ak_log 0
scoreboard players set @a ak_secret 0
schedule clear aisu_escape:countdown
schedule clear aisu_escape:drone
bossbar set aisu_escape:countdown visible false
clear @a written_book
title @a title {"text":""}
tellraw @a {"text":"[Atoll] Zuruckgesetzt.","color":"aqua"}
function aisu_escape:load
