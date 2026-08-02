# Quietschender Drohnen-Ambient — laeuft in Schleife, solange der Lauf aktiv ist.
# Der Custom-Sound liegt im Resource Pack (aisu_escape:ambient.drone.squeak).
execute unless score #game ak_state matches 1 run return 0

# Lautstaerke steigt, je weniger Zeit bleibt (3 Stufen).
#   > 300 s : leise (0.4)   |   61..300 s : mittel (0.7)   |   <= 60 s : laut (1.0)
execute if score #game ak_time matches 301.. run playsound aisu_escape:ambient.drone.squeak ambient @a ~ ~ ~ 0.4 1
execute if score #game ak_time matches 61..300 run playsound aisu_escape:ambient.drone.squeak ambient @a ~ ~ ~ 0.7 1
execute if score #game ak_time matches ..60 run playsound aisu_escape:ambient.drone.squeak ambient @a ~ ~ ~ 1 0.9

# In 8 Sekunden erneut abspielen (= Laenge der .ogg-Schleife; bei anderer Laenge anpassen)
execute if score #game ak_state matches 1 run schedule function aisu_escape:drone 8s replace
