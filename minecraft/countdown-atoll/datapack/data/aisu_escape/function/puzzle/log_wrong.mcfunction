# Falsche Minute — Rueckmeldung an den einen Spieler (@s)
tellraw @s [{"text":"[Wache] ","color":"red"},{"text":"Da patrouilliert jemand. Schau nochmal: welche Zahl fehlt in der Reihe 05 10 15 20 _ 30 35?","color":"gray"}]
playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5
scoreboard players set @s ak_log 0
scoreboard players enable @s ak_log
