# Falsche Verschiebung — Rueckmeldung an den einen Spieler (@s)
tellraw @s [{"text":"[Rad] ","color":"red"},{"text":"Das ergibt kein Wort. Dreh weiter und versuch eine andere Zahl.","color":"gray"}]
playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.6
# Rad zuruecksetzen und wieder freischalten
scoreboard players set @s ak_dial 0
scoreboard players enable @s ak_dial
