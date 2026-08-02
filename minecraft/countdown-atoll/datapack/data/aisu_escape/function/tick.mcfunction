# Laeuft jeden Game-Tick (20x/s). Prueft nur waehrend eines aktiven Laufs.
execute unless score #game ak_state matches 1 run return 0

# --- Stufe 1: Caesar-Chiffre (Chiffrier-Rad ak_dial) ---
execute if score #game ak_stage matches 1 as @a[scores={ak_dial=3}] at @s run function aisu_escape:puzzle/caesar_solved
execute if score #game ak_stage matches 1 as @a[scores={ak_dial=1..2}] run function aisu_escape:puzzle/caesar_wrong
execute if score #game ak_stage matches 1 as @a[scores={ak_dial=4..}] run function aisu_escape:puzzle/caesar_wrong

# --- Stufe 2: Alarmanlage / NOT-Gatter (ak_alarm) ---
# Kontrollleuchten 0110 -> NOT -> 1001. Richtige Eingabe: 1001
execute if score #game ak_stage matches 2 as @a[scores={ak_alarm=1001}] at @s run function aisu_escape:puzzle/alarm_solved
execute if score #game ak_stage matches 2 as @a[scores={ak_alarm=1..1000}] run function aisu_escape:puzzle/alarm_wrong
execute if score #game ak_stage matches 2 as @a[scores={ak_alarm=1002..}] run function aisu_escape:puzzle/alarm_wrong
