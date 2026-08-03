# Richtige PIN (1946) -> Kamera aus. Alle drei Stufen geloest -> Sieg.
scoreboard players set @s ak_cam 0
scoreboard players set #game ak_stage 9

tellraw @a [{"text":"[Kamera] ","color":"green"},{"text":"PIN 1946 akzeptiert — Aufzeichnung gestoppt.","color":"gray"}]
tellraw @a {"text":"Merke: Werks-PINs und Standard-Passwoerter sind das haeufigste Sicherheitsproblem ueberhaupt. Immer aendern!","color":"yellow","italic":true}
playsound minecraft:block.note_block.chime master @a ~ ~ ~ 1 1.5

function aisu_escape:win
