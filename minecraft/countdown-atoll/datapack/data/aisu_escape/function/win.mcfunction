# Entkommen! Countdown stoppen.
scoreboard players set #game ak_state 2
schedule clear aisu_escape:countdown
schedule clear aisu_escape:drone
bossbar set aisu_escape:countdown visible false

title @a times 10 60 20
title @a title {"text":"ENTKOMMEN","bold":true,"color":"green"}
title @a subtitle {"text":"Du hast das Atoll rechtzeitig verlassen.","color":"gray"}

# Rest-Zeit als Bonus zeigen
tellraw @a [{"text":"Verbleibende Zeit als Bonus: ","color":"gray"},{"score":{"name":"#game","objective":"ak_time"},"color":"green"},{"text":" Sekunden.","color":"gray"}]

# Bestenlisten-Code fuer die Website (Platzhalter — in der Vollversion zufaellig/routenabhaengig)
tellraw @a [{"text":"Dein Code fuer die Bestenliste: ","color":"aqua"},{"text":"ATOLL-BOOT-01","bold":true,"color":"yellow","clickEvent":{"action":"copy_to_clipboard","value":"ATOLL-BOOT-01"},"hoverEvent":{"action":"show_text","contents":"Klicken zum Kopieren"}}]
tellraw @a {"text":"Gib ihn auf lab.aisu.studio ein, um dich einzutragen.","color":"gray"}

playsound minecraft:ui.toast.challenge_complete master @a ~ ~ ~ 1 1
