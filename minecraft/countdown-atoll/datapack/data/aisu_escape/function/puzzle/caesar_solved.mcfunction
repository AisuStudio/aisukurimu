# Richtige Verschiebung (3) -> Klartext BOOT. Raetsel geloest.
scoreboard players set #game ak_solved 1
scoreboard players set @s ak_dial 0

tellraw @a [{"text":"[Rad] ","color":"green"},{"text":"E R R W","strikethrough":true,"color":"dark_gray"},{"text":"  ->  ","color":"gray"},{"text":"B O O T","bold":true,"color":"green"}]
tellraw @a {"text":"Verschiebung 3 geknackt! Der Zugangscode lautet BOOT. Das letzte Boot ist frei.","color":"aqua"}
playsound minecraft:block.note_block.chime master @a ~ ~ ~ 1 1.5

# In der Vollversion oeffnet sich hier die Tuer / der Bootssteg.
# Im Prototyp ist dieses Raetsel der Sieg-Schritt.
function aisu_escape:win
