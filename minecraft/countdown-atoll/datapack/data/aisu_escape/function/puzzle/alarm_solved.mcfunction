# Richtiger Alarm-Code (1001) -> Anlage aus. Stufe 2 geloest.
scoreboard players set @s ak_alarm 0

tellraw @a [{"text":"[Alarm] ","color":"green"},{"text":"0 1 1 0","strikethrough":true,"color":"dark_gray"},{"text":"  --NOT-->  ","color":"gray"},{"text":"1 0 0 1","bold":true,"color":"green"}]
tellraw @a {"text":"Alarm deaktiviert! Aber eine Ueberwachungskamera filmt noch den Bootssteg.","color":"aqua"}
playsound minecraft:block.note_block.chime master @a ~ ~ ~ 1 1.5

# Weiter zu Stufe 3: Kamera
scoreboard players set #game ak_stage 3
function aisu_escape:puzzle/give_camera
