# Richtiger Alarm-Code (1001) -> Anlage aus. Beide Stufen geloest -> Sieg.
scoreboard players set @s ak_alarm 0
scoreboard players set #game ak_stage 9

tellraw @a [{"text":"[Alarm] ","color":"green"},{"text":"0 1 1 0","strikethrough":true,"color":"dark_gray"},{"text":"  --NOT-->  ","color":"gray"},{"text":"1 0 0 1","bold":true,"color":"green"}]
tellraw @a {"text":"Alarm deaktiviert! Der Bootssteg ist frei — nichts haelt dich mehr.","color":"aqua"}
playsound minecraft:block.note_block.chime master @a ~ ~ ~ 1 1.5

function aisu_escape:win
