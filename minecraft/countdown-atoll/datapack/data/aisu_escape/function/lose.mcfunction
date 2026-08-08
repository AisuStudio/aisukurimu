# Zeit abgelaufen — kein "Game Over", nur Neustart-Angebot.
scoreboard players set #game ak_state 3
scoreboard players set #game ak_time 0
schedule clear aisu_escape:countdown
schedule clear aisu_escape:drone
execute store result bossbar aisu_escape:countdown value run scoreboard players get #game ak_time
bossbar set aisu_escape:countdown visible false
clear @a written_book

title @a times 10 60 20
title @a title {"text":"COUNTDOWN ABGELAUFEN","color":"red"}
title @a subtitle {"text":"Die Evakuierung ist ohne dich gestartet.","color":"gray"}
tellraw @a {"text":"Kein Problem — waehle einfach eine neue Route:","color":"gray"}

playsound minecraft:block.bell.use master @a ~ ~ ~ 1 0.5

# Neustart ohne Cheats: Menue erneut zeigen (Routenwahl per Trigger)
function aisu_escape:menu
