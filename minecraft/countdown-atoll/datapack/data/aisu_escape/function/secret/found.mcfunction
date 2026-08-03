# Geheime Losung "Ken sent me" gefunden — einmaliger Bonus (@s).
scoreboard players set @s ak_secret 1

# Zeit-Bonus: 60 Sekunden extra vom Schmuggler
scoreboard players add #game ak_time 60
execute store result bossbar aisu_escape:countdown value run scoreboard players get #game ak_time

title @s times 5 40 15
title @s title {"text":"Losung akzeptiert","color":"gold"}
title @s subtitle {"text":"\"Ken sent me\" — der Schmuggler nickt.","color":"gray"}
tellraw @s {"text":"[Schmuggler] Kenn ich. Ken schuldet mir noch was. +60 Sekunden — aber psst.","color":"gold"}
tellraw @s [{"text":"Geheimer Bonus-Code: ","color":"aqua"},{"text":"KEN-SENT-ME","bold":true,"color":"yellow","clickEvent":{"action":"copy_to_clipboard","value":"KEN-SENT-ME"},"hoverEvent":{"action":"show_text","contents":"Klicken zum Kopieren"}}]
playsound minecraft:entity.villager.yes master @s ~ ~ ~ 1 1
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.8 1.8
