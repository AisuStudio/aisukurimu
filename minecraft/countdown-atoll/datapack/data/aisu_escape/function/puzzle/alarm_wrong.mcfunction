# Falscher Alarm-Code — Rueckmeldung an den einen Spieler (@s)
tellraw @s [{"text":"[Alarm] ","color":"red"},{"text":"Falsches Muster — die Sirene heult kurz auf. Denk an NOT: jedes Bit umdrehen.","color":"gray"}]
playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5
# Countdown-Strafe: 10 Sekunden Abzug fuers Auloesen des Alarms
scoreboard players remove #game ak_time 10
# Panel zuruecksetzen und wieder freischalten
scoreboard players set @s ak_alarm 0
scoreboard players enable @s ak_alarm
