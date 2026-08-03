# Falsche Kamera-PIN — Rueckmeldung an den einen Spieler (@s)
tellraw @s [{"text":"[Kamera] ","color":"red"},{"text":"PIN abgelehnt. Tipp: Es steht direkt auf dem Schild am Gehaeuse.","color":"gray"}]
playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5
# Panel zuruecksetzen und wieder freischalten
scoreboard players set @s ak_cam 0
scoreboard players enable @s ak_cam
