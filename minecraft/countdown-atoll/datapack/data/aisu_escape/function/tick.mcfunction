# Laeuft jeden Game-Tick (20x/s). Prueft nur waehrend eines aktiven Laufs.
execute unless score #game ak_state matches 1 run return 0
execute if score #game ak_solved matches 1 run return 0

# Richtige Verschiebung (3) eingestellt -> geloest
execute as @a[scores={ak_dial=3}] at @s run function aisu_escape:puzzle/caesar_solved

# Falsche Zahl eingestellt -> Rueckmeldung, Rad zuruecksetzen, neu freischalten
execute as @a[scores={ak_dial=1..2}] run function aisu_escape:puzzle/caesar_wrong
execute as @a[scores={ak_dial=4..}] run function aisu_escape:puzzle/caesar_wrong
