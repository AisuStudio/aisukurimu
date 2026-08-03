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

# --- Stufe 3: Kamera / Werks-PIN (ak_cam) ---
# PIN = Baujahr 1946. Richtige Eingabe: 1946
execute if score #game ak_stage matches 3 as @a[scores={ak_cam=1946}] at @s run function aisu_escape:puzzle/camera_solved
execute if score #game ak_stage matches 3 as @a[scores={ak_cam=1..1945}] run function aisu_escape:puzzle/camera_wrong
execute if score #game ak_stage matches 3 as @a[scores={ak_cam=1947..}] run function aisu_escape:puzzle/camera_wrong

# --- Stufe 4: Patrouillen-Log / Forensik (ak_log) ---
# Fehlende Minute in 05 10 15 20 _ 30 35 -> 25. Richtige Eingabe: 25
execute if score #game ak_stage matches 4 as @a[scores={ak_log=25}] at @s run function aisu_escape:puzzle/log_solved
execute if score #game ak_stage matches 4 as @a[scores={ak_log=1..24}] run function aisu_escape:puzzle/log_wrong
execute if score #game ak_stage matches 4 as @a[scores={ak_log=26..}] run function aisu_escape:puzzle/log_wrong

# --- Easter Egg: geheime Losung "Ken sent me" (jederzeit waehrend des Laufs) ---
# Erkannt, wenn der Spieler ein Item in der Hand haelt, das im Amboss in genau
# "Ken sent me" umbenannt wurde. Zwei Varianten decken die NBT-Serialisierung
# verschiedener 1.21-Versionen ab (String- vs. Objekt-Textkomponente).
execute as @a[scores={ak_secret=0},nbt={SelectedItem:{components:{"minecraft:custom_name":'"Ken sent me"'}}}] run function aisu_escape:secret/found
execute as @a[scores={ak_secret=0},nbt={SelectedItem:{components:{"minecraft:custom_name":'{"text":"Ken sent me"}'}}}] run function aisu_escape:secret/found
