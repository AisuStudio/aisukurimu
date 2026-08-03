# Richtige Verschiebung (3) -> Klartext BOOT. Stufe 1 geloest.
scoreboard players set @s ak_dial 0

tellraw @a [{"text":"[Rad] ","color":"green"},{"text":"E R R W","strikethrough":true,"color":"dark_gray"},{"text":"  ->  ","color":"gray"},{"text":"B O O T","bold":true,"color":"green"}]
tellraw @a {"text":"Verschiebung 3 geknackt! Der Weg zum Bootssteg ist offen — aber eine Alarmanlage sichert ihn.","color":"aqua"}
playsound minecraft:block.note_block.chime master @a ~ ~ ~ 1 1.5

# Weiter zu Stufe 2: Alarmanlage
scoreboard players set #game ak_stage 2
function aisu_escape:puzzle/give_alarm
