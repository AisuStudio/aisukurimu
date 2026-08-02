# Zeit abgelaufen — kein "Game Over", nur Neustart-Angebot.
scoreboard players set #game ak_state 3
scoreboard players set #game ak_time 0
schedule clear aisu_escape:countdown
schedule clear aisu_escape:drone
execute store result bossbar aisu_escape:countdown value run scoreboard players get #game ak_time

title @a times 10 60 20
title @a title {"text":"COUNTDOWN ABGELAUFEN","color":"red"}
title @a subtitle {"text":"Die Evakuierung ist ohne dich gestartet.","color":"gray"}
tellraw @a [{"text":"Kein Problem — ","color":"gray"},{"text":"[ Nochmal versuchen ]","bold":true,"color":"green","clickEvent":{"action":"run_command","value":"/function aisu_escape:reset"},"hoverEvent":{"action":"show_text","contents":"Setzt alles zurueck"}}]

playsound minecraft:block.bell.use master @a ~ ~ ~ 1 0.5
