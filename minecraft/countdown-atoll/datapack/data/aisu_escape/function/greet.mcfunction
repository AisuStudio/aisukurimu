# Wird pro Spieler EINMAL ausgefuehrt, sobald er in der Welt ist (vom tick aufgerufen).
scoreboard players set @s ak_seen 1
scoreboard players enable @s ak_route
title @s times 10 60 20
title @s title {"text":"Countdown auf dem Atoll","color":"red"}
title @s subtitle {"text":"Waehle im Chat eine Route","color":"gray"}
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
function aisu_escape:menu
