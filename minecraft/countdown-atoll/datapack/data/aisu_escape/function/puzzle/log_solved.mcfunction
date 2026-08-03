# Richtige Minute (25) -> freies Zeitfenster gefunden. Alle Stufen geloest -> Sieg.
scoreboard players set @s ak_log 0
scoreboard players set #game ak_stage 9

tellraw @a [{"text":"[Wache] ","color":"green"},{"text":"Minute 25 — die Luecke im Muster. Der Steg ist frei.","color":"gray"}]
tellraw @a {"text":"Spuren lesen: Logs verraten Muster, und Muster verraten die Luecke. Genau so arbeitet Forensik.","color":"yellow","italic":true}
playsound minecraft:block.note_block.chime master @a ~ ~ ~ 1 1.5

function aisu_escape:win
