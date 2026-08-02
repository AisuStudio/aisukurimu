# Dezenter Warnton alle 5 Sekunden im mittleren Zeitbereich (61..300 s)
scoreboard players operation #mod ak_time = #game ak_time
scoreboard players operation #mod ak_time %= #five ak_time
execute if score #mod ak_time matches 0 run playsound minecraft:block.note_block.hat master @a ~ ~ ~ 0.4 1.2
