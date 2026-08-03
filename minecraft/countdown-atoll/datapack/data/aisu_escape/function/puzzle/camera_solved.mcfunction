# Richtige PIN (1946) -> Kamera aus. Stufe 3 geloest.
scoreboard players set @s ak_cam 0

tellraw @a [{"text":"[Kamera] ","color":"green"},{"text":"PIN 1946 akzeptiert — Aufzeichnung gestoppt.","color":"gray"}]
tellraw @a {"text":"Merke: Werks-PINs und Standard-Passwoerter sind das haeufigste Sicherheitsproblem ueberhaupt. Immer aendern!","color":"yellow","italic":true}
playsound minecraft:block.note_block.chime master @a ~ ~ ~ 1 1.5

# Weiter zu Stufe 4: Patrouillen-Log
scoreboard players set #game ak_stage 4
function aisu_escape:puzzle/give_log
