;;This is stable release, intended for easier modification

breed [player friedchicken]
breed [boss enemyboss]
breed [enemyA goonA]
breed [enemyB goonB]
breed [enemyC goonC]
breed [playerbullet bulletA]
breed [enemybullet bulletE]
breed [bulletMA mokobulletA]
breed [bulletMB mokobulletB]
breed [bulletMC mokobulletC]
breed [bulletMD mokobulletD]
breed [spawnerA spA]
breed [spawnerB spB]
breed [spawnerC spC]

globals[
  action            ;;Last button pressed. Prevent the player from moving FriedChicken until the
                    ;; the game is running.  Checks the status of this button every loop.
  level             ;;Current level
  lives             ;;Player's Lives
  BossHP            ;;Boss' Health Points
  Score             ;;The score that the player have accumulated
  bossgoesright?    ;; 0: go right 1:go left, Boss Movement
]

to setup
  clear-all
  set action 0
  set bossgoesright? 0
  set level Start-level
  next-level
  reset-ticks
end

to go
  tick
  bullet
  check
  movement
  playermove
end

to next-level
  if( level = 1 )
  [ level-1 ]
  if( level = 2 )
  [ level-2 ]
  if( level = 3 )
  [ level-3 ]
  if( level = 4 )
  [ user-message "You have completed the game wow! :V" ]
end

;;;;;;;;;;;;;;;;;;
;;Create Turtles;;
;;;;;;;;;;;;;;;;;;

to create-bullet
  set-default-shape bulletMA "mokobulleta"
  set-default-shape bulletMB "mokobulletb"
  set-default-shape bulletMC "mokobulletc"
  set-default-shape bulletMD "mokobulletD"
  set-default-shape playerbullet "bullet2"
  set-default-shape enemybullet "bullet1"
end

to create-spawner
  set-default-shape spawnerA "spawner"
  set-default-shape spawnerB "spawner"
  set-default-shape spawnerC "spawner"

   create-spawnerA 1[
    set size 1
    setxy -3 15
  ]
   create-spawnerA 1[
    set size 1
    setxy 3 15
  ]
   create-spawnerA 1[
    set size 1
    setxy -10 15
  ]
   create-spawnerA 1[
    set size 1
    setxy 10 15
  ]
    create-spawnerB 1[
    set size 1
    setxy -14 15
  ]
   create-spawnerB 1[
    set size 1
    setxy 14 15
  ]
   create-spawnerB 1[
    set size 1
    setxy -6 15
  ]
   create-spawnerB 1[
    set size 1
    setxy 6 15
  ]
   create-spawnerC 1[
    set size 1
    setxy -8 15
  ]
   create-spawnerC 1[
    set size 1
    setxy 8 15
  ]
    create-spawnerC 1[
    set size 1
    setxy 0 15
  ]
end

to create-enemy-VXSeries
  set-default-shape enemyA "vx-1"
  set-default-shape enemyB "vx-2"
  set-default-shape enemyC "vx-3"
end

to create-player-friedchicken
  set-default-shape player "friedchicken"
  set lives 3
  create-player 1[
    set size 4
    setxy 0 -14
  ]
end

to create-boss-cookie
  set-default-shape boss "vu-1"
  set BossHP 15
  create-boss 1[
    set size 5
    setxy 1 13
  ]
end

to create-boss-lecheflan
  set-default-shape boss "lecheflan"
  set BossHP 25
  create-boss 1[
    set size 5
    setxy 1 13
  ]
end

to create-boss-Moko
  set-default-shape boss "moko"
  set BossHP 22
  create-boss 1[
    set size 4
    setxy 1 13
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Player-Command Procedures;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to playermove
  move-friedchicken
end

to move-friedchicken
if (action != 0)[
   if (action = 1)
    [move-left]
   if (action = 2)
    [move-right]
   if (action = 3)
    [move-down]
   if (action = 4)
    [move-up]
   if (action = 5)
    [shoot]
   set action 0
  ]
end

to shoot
  ask player[
    hatch-playerbullet 1[set size 4]
  ]
end

to fire
  ask playerbullet[
    set heading 0
    fd 1
  ]
end

to move-left
 ask player[
    set heading 270
    fd 1
    ]
end

to move-right
 ask player[
    set heading 90
    fd 1
    ]
end

to move-up
 ask player[
    set heading 0
    fd 1
    ]
end

to move-down
 ask player[
    set heading 180
    fd 1
    ]
end

;;;;;;;;;;;;;;;;;;;;
;;General Movement;;
;;;;;;;;;;;;;;;;;;;;

to movement
  if ( level = 1 )[
    cookie-movement
  ]
  if ( level = 2 )[
    spawn
    lecheflan-movement
    vxA-movement
    vxB-movement
    vxC-movement
  ]
  if ( level = 3 )[
    moko-movement
  ]
end

to vxA-movement
 ask enemyA[
    fd 0.18
    if (any? player-here)[
      set lives (lives - 1)
      set Score (Score - 50)
      die
    ]
    if (any? playerbullet-here)[die]
  ]
end

to vxB-movement
 ask enemyB[
    fd 0.15
    if ((random 100) > 98 )[hatch-enemybullet 1[set size 4]]
    if (any? player-here)[
      set lives (lives - 1)
      set Score (Score - 50)
      die
    ]
    if (any? playerbullet-here)[die]
  ]
end

to vxC-movement
 ask enemyC[
    fd 0.11
    if ((random 100) > 98.90 )[
      hatch-enemybullet 1 [set heading 180 set size 4 set color turquoise]
      hatch-enemybullet 1 [set heading 175 set size 4]
      hatch-enemybullet 1 [set heading -175 set size 4]
    ]
    if (any? player-here)[
      set lives (lives - 1)
      set Score (Score - 50)
      die
    ]
    if (any? playerbullet-here)[die]
  ]
end

to cookie-movement
  ask boss[
    set heading 270
  ]
  if (BossHP > 8)[
    ask boss[
     if ((random 100) > 98 )[
      hatch-enemybullet 1 [set heading 180 set color violet set size 4]
      hatch-enemybullet 1 [set heading 175 set color green set size 4]
      hatch-enemybullet 1 [set heading -175 set color green set size 4]
      ]
    ]
  ]
  if (BossHP <= 8)[
   ask boss[
     if ((random 100) > 96.5 )[
      hatch-enemybullet 1 [set heading 180 set color turquoise set size 4]
      hatch-enemybullet 1 [set heading 175 set color violet set size 4]
      hatch-enemybullet 1 [set heading -175 set color violet set size 4]
      hatch-enemybullet 1 [set heading 170 set color green set size 4]
      hatch-enemybullet 1 [set heading -170 set color green set size 4]
      hatch-enemybullet 1 [set heading 165 set color violet set size 4]
      hatch-enemybullet 1 [set heading -165 set color violet set size 4]
      hatch-enemybullet 1 [set heading 160 set color green set size 4]
      hatch-enemybullet 1 [set heading -160 set color green set size 4]
     ]
   ]
  ]
 ask boss[
     ifelse bossgoesright? = 0 [
       set xcor xcor + 0.25
       if xcor = 13[ set bossgoesright? 1]
       ][
      set xcor xcor - 0.25
      if xcor = -13[ set bossgoesright? 0]
      ]
  ]
end

to lecheflan-movement
  ask boss[
      set heading 270
  ]
  if (BossHP > 7)[
    ask boss[
       if ((random 100) > 96 )[
      hatch-enemybullet 1 [set heading 180 set color green set size 4]
      hatch-enemybullet 1 [set heading 175 set color violet set size 4]
      hatch-enemybullet 1 [set heading -175 set color violet set size 4]
      ]
    ]
  ]
  if (BossHP <= 7)[
    ask boss[
       if ((random 100) > 98 )[
      hatch-enemybullet 1 [set heading 180 set color green set size 4]
      hatch-enemybullet 1 [set heading 175 set color violet set size 4]
      hatch-enemybullet 1 [set heading -175 set color violet set size 4]
      hatch-enemybullet 1 [set heading 170 set color green set size 4]
      hatch-enemybullet 1 [set heading -170 set color green set size 4]
      hatch-enemybullet 1 [set heading 165 set color turquoise set size 4]
      hatch-enemybullet 1 [set heading -165 set color turquoise set size 4]
      ]
    ]
  ]
  ask boss[
     ifelse bossgoesright? = 0 [
       set xcor xcor + 0.25
       if xcor = 13[ set bossgoesright? 1]
       ][
      set xcor xcor - 0.25
      if xcor = -13[ set bossgoesright? 0]
      ]
  ]
end

to moko-movement
  if (BossHP > 6)[
   ask boss[
     if ((random 100) > 97.5 )[
      hatch-enemybullet 1 [set heading 180 set color red set size 4]
      hatch-enemybullet 1 [set heading 175 set color red set size 4]
      hatch-enemybullet 1 [set heading -175 set color red set size 4]
     ]
   ]
  ]
  if (BossHP <= 16)[
    ask boss[
     if ((random 100) > 97.80 )[
      hatch-bulletMA 1 [set heading 180 set color red set size 4]
      hatch-bulletMA 1 [set heading 175 set color violet set size 4]
      hatch-bulletMA 1 [set heading -175 set color violet set size 4]
      ]
    ]
  ]
   if (BossHP <= 16)[
    ask boss[
    if ((random 100) > 98 )[
      hatch-bulletMB 1 [set heading 180 set size 4]
      ]
    ]
  ]
  if (BossHP <= 14)[
    ask boss[
    if ((random 100) > 98 )[
      hatch-bulletMC 1 [set heading 180 set size 4]
      ]
    ]
  ]
  if (BossHP <= 9)[
    ask bulletMB[
    if ((random 100) > 98.80 )[
      hatch-bulletMA 1[set heading 0 set size 4 set color blue]
      hatch-bulletMA 1[set heading 180 set size 4 set color blue]
      hatch-bulletMA 1[set heading 270 set size 4 set color blue]
      hatch-bulletMA 1[set heading 90 set size 4 set color blue]
      hatch-bulletMA 1[set heading 225 set size 4 set color blue]
      hatch-bulletMA 1[set heading 315 set size 4 set color blue]
      hatch-bulletMA 1[set heading 45 set size 4 set color blue]
      hatch-bulletMA 1[set heading 135 set size 4 set color blue]
      die
      ]
    ]
   ask boss[
    if ((random 100) > 98.9 )[
      hatch-bulletMD 1 [set heading 90 set size 4]
      ]
    if ((random 100) > 98.9 )[
      hatch-bulletMD 1 [set heading 270 set size 4]
      ]
    ]
  ]
  if (BossHP <= 6)[
    ask boss[
    if ((random 100) > 96 )[
      hatch-bulletMA 1 [set heading 180 set color yellow set size 3]
      hatch-bulletMA 1 [set heading 175 set color yellow set size 3]
      hatch-bulletMA 1 [set heading -175 set color yellow set size 3]
      hatch-bulletMA 1 [set heading 170 set color yellow set size 3]
      hatch-bulletMA 1 [set heading -170 set color yellow set size 3]
      ]
    ]
  ]
  ask boss[
  if (any? player-here)[
       set lives (lives - 1)
       set Score (Score - 50)
    ]
  ]
   ask boss[
     ifelse bossgoesright? = 0 [
       set xcor xcor + 0.25
       if xcor = 13[ set bossgoesright? 1]
       ][
      set xcor xcor - 0.25
      if xcor = -13[ set bossgoesright? 0]
      ]
  ]
end

;;;;;;;;;
;;Check;;
;;;;;;;;;

to check
  check-boss
  check-player
end

to check-player
  if (lives <= 0)[
  ask player[die]
    clear-turtles
    reset-ticks
    import-drawing "GameOverScreen.png"
    stop
  ]
  ask player[
   if (any? boss-here)[
       set lives (lives - 1)
       set Score (Score - 50)
   ]
  ]
end

to check-boss
    if (BossHP <= 0)[
    ask boss[die]
    clear-turtles
    reset-ticks
    import-drawing "VictoryScreen.png"
    stop
 ]
end

;;;;;;;;;;
;;bullet;;
;;;;;;;;;;

to bullet
  if ( level = 1 )[
  bulletP
  bulletEnemy
  ]
  if ( level = 2 )[
  bulletP
  bulletEnemy
  ]
  if ( level = 3 )[
  bulletP
  bulletEnemy
  bulletMokoA
  bulletMokoB
  bulletMokoC
  bulletMokoD
  ]
  if ( level = 4 )[

  ]
end

to bulletP
  ask playerbullet[
    set color red
    set heading 0
    fd 0.25
    if ycor >= max-pycor [die]
    if (any? boss-here)[
      set BossHP (BossHP - 1)
      set Score (Score + 1)
      die
    ]
    if ( level = 2 )[
      if (any? enemyA-here)[set Score (Score + 10) die]
      if (any? enemyB-here)[set Score (Score + 15) die]
      if (any? enemyC-here)[set Score (Score + 30) die]
    ]
    if ( level = 3 )[
      if (any? bulletMA-here)[die]
      if (any? bulletMB-here)[die]
      if (any? bulletMC-here)[die]
    ]
  ]
end

to bulletEnemy
  ask enemybullet[
    fd 0.2
      if ycor >= max-pycor [die]
      if xcor >= max-pycor [die]
      if ycor <= min-pxcor [die]
      if xcor <= min-pxcor [die]
  if (any? player-here)[
      set lives (lives - 1)
      set Score (Score - 50)
      die
     ]
  ]
end

to bulletMokoA
  ask bulletMA[
    fd 0.15
    if ycor >= max-pycor [die]
    if xcor >= max-pycor [die]
    if ycor <= min-pxcor [die]
    if xcor <= min-pxcor [die]
    if (any? player-here)[
      set lives (lives - 1)
      set Score (Score - 50)
      die
    ]
  ]
end

to bulletMokoB
  ask bulletMB[
    fd 0.10
      if ycor >= max-pycor [die]
      if xcor >= max-pycor [die]
      if ycor <= min-pxcor [die]
      if xcor <= min-pxcor [die]
    if (any? player-here)[
      set lives (lives - 1)
      set Score (Score - 50)
      die
    ]
    if (any? playerbullet-here)[
      set Score (Score + 10)
      die
    ]
  ]
end

to bulletMokoC
  ask bulletMC[
    set heading -180
    fd 0.25
      if ycor >= max-pycor [die]
      if xcor >= max-pycor [die]
      if ycor <= min-pxcor [
          hatch-bulletMA 1[set heading   0   set size 4 set color green]
          hatch-bulletMA 1[set heading  20   set size 4 set color green]
          hatch-bulletMA 1[set heading -20   set size 4 set color green]
          hatch-bulletMA 1[set heading  40   set size 4 set color green]
          hatch-bulletMA 1[set heading -40   set size 4 set color green]
          die
    ]
     if xcor <= min-pxcor [die]
    if (any? player-here)[
      set lives (lives - 1)
      set Score (Score - 50)
      die
    ]
    if (any? playerbullet-here)[
      set Score (Score + 10)
      die
    ]
  ]
end

to bulletMokoD
  ask bulletMD[
    fd 0.10
    if xcor >= max-pycor [
      hatch-bulletMA 1[set heading 210 set size 4 set color pink]
      hatch-bulletMA 1[set heading 240 set size 4 set color pink]
      die
    ]
    if xcor <= min-pxcor [
      hatch-bulletMA 1[set heading -210 set size 4 set color pink]
      hatch-bulletMA 1[set heading -240 set size 4 set color pink]
      die
    ]
   if (any? player-here)[
      set lives (lives - 1)
      set Score (Score - 50)
      die
    ]
   if (any? playerbullet-here)[
      set Score (Score + 10)
      die
    ]
  ]
end

;;;;;;;;;;;
;;Spawner;;
;;;;;;;;;;;

to spawn
  ask enemyA[if ycor <= min-pxcor [die]]
  ask enemyB[if ycor <= min-pxcor [die]]
  ask enemyC[if ycor <= min-pxcor [die]]
  if ( level = 2 )[
    if (BossHP <= 17)[
       ask spawnerA[if ((random 100) < 0.1 )[hatch-enemyA 1[set size 4 set heading 180]]]
    ]
    if (BossHP <= 14)[
       ask spawnerB[if ((random 100) < 0.1 )[hatch-enemyB 1[set size 4 set heading 180]]]
    ]
    if (BossHP <= 9)[
      ask spawnerC[if ((random 100) < 0.1 )[hatch-enemyC 1[set size 4 set heading 180]]]
    ]
  ]
end

;;;;;;;;;;;;;;;;;
;;Level Creator;;
;;;;;;;;;;;;;;;;;

to level-1
  create-bullet
  create-boss-cookie
  create-player-friedchicken
end

to level-2
  create-player-friedchicken
  create-boss-lecheflan
  create-enemy-VXSeries
  create-spawner
  create-bullet
end

to level-3
  create-bullet
  create-boss-Moko
  create-player-friedchicken
end

to level-4


end

;;Puchina(2019)
@#$#@#$#@
GRAPHICS-WINDOW
280
10
725
456
-1
-1
13.242424242424242
1
10
1
1
1
0
0
0
1
-16
16
-16
16
1
1
1
ticks
30.0

BUTTON
12
28
102
61
New Game
Setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
94
382
157
415
UP
set action 4
NIL
1
T
OBSERVER
NIL
W
NIL
NIL
0

BUTTON
91
416
160
449
DOWN
set action 3
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
0

BUTTON
28
416
91
449
LEFT
set action 1
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
0

BUTTON
160
416
227
449
RIGHT
set action 2
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
0

BUTTON
102
28
168
61
Start
Go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
93
333
157
366
FIRE
set action 5
NIL
1
T
OBSERVER
NIL
F
NIL
NIL
0

SLIDER
10
101
114
134
Start-level
Start-level
1
4
1.0
1
1
NIL
HORIZONTAL

MONITOR
140
149
237
194
Enemy Boss HP
BossHP
0
1
11

MONITOR
140
202
238
247
Current Level
Level
0
1
11

MONITOR
141
254
238
299
Score
Score
17
1
11

MONITOR
140
99
236
144
Player's Lives
Lives
17
1
11

TEXTBOX
748
16
898
128
Note:\n\nHitting the wing of the plane doesn't deal damage.\n\ninorder to destroy your opponents you must shoot directly to their cockpit
11
101.0
1

@#$#@#$#@
## WHAT IS IT?

This Model is based on bullet hell games and space shooter games. The objective of the game is to defeat the Boss at the top of the screen while avoiding the endless wave of projectiles.

## HOW IT WORKS

When the Boss reached a certain amount of HP, it will begin to unleash new projectiles that will challenge the player to move to a safer zone or it will spawn new enemies that will help the boss keep the player at bay.

To win this game you must bring down the Boss HP to 0 and you will also lose if your player lives reach to 0. 

--Note that you are given only three lives at the start of each level.--

## HOW TO USE IT

Buttons

- **NEW GAME** resets the game
- **START** starts the game
- The **direction buttons** (**UP**, **DOWN**, **LEFT**, **RIGHT**) will move your player in that direction
- **FIRE** your player character will shoot projectiles

Monitor

- **PLAYER LIVES** tells you how many remaining lives your have
- **ENEMY BOSS HP** tells you how many remaining health points the enemy Boss have
- **CURRENT LEVEL** monitors the current level you are playing
- **SCORE** tells you the current score you have achieve in the current level

Sliders

- **START-LEVEL** used to select which level you want to start with

Cast of Characters:

- **Fried Chicken**: This is your player character who piloted the red-white plane.
- **Cookie**: The tutorial boss in the first level, identified by its UFO-like appearance.
- **LecheFlan**: The enemy boss of the second level, identified by its green-purple color scheme.
- **VX-Ship Series**: LecheFlan's goons, can be found on the second level.
- **Moko**: A parody character based from a character of Touhou Project, Fujiwara Mokou. can be found on third level.
  
## THINGS TO NOTICE

Hitting the wing of the plane doesn't deal damage.

inorder to destroy your opponents you must shoot directly to their cockpit

**First Level**:

Cookie will always move right to left while shooting easy-to-dodge projectiles.
fighting her will be no problem ;)

**Second Level**:

Similar to Cookie, LecheFlan will always move Right to Left while shooting projectiles, it may be seem easy to dodge but be wary that she has her own reinforcement as her BossHP wittles down.

VX-1 are the fast moving ships without any form of weaponry but be sure not to get in their way.

VX-2 are the ships that shoot projectiles in a straight line.

VX-3 are the ships similar to LecheFlan that shoot triple bullet. engage with caution.

**Third Level**:

As the BossHP goes down, Moko will begin unleashing new attack patterns and some of the projectiles can also block your projectile so you must find a opening that you can be able to attack Moko.

## THINGS TO TRY

Beat your Highest Score.

Try to win without losing a single life

After defeating the first level Boss, take out the second boss!

## EXTENDING THE MODEL

-temporary invincibility after getting hit by a projectile
-Powerups
-New Boss with different gimmick
-Add new enemies with different behavior
-Projectile Patterns

## NETLOGO FEATURES

This Model uses breeds, random, globals and user-message.

## RELATED MODELS

**Frogger**: For the movement and check/die.
**Projectile Attack**: For the fire button and projectiles.
**Pacman**: For the levels.

## CREDITS AND REFERENCE TO RELATED MODELS

Frogger:

* Wilensky, U. (2002).  NetLogo Frogger model.  http://ccl.northwestern.edu/netlogo/models/Frogger.  Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

Projectile Attack:

* Wilensky, U. (2008).  NetLogo Projectile Attack model.  http://ccl.northwestern.edu/netlogo/models/ProjectileAttack.  Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

Pacman:

* Wilensky, U. (2001).  NetLogo Pac-Man model.  http://ccl.northwestern.edu/netlogo/models/Pac-Man.  Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

## CREDITS AND REFERENCES TO THIS MODEL

If you mention this model or take an adaptation to it, please include the citation below.

* Lance (2019). NetLogo V-Wingers.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplanelife
false
0
Polygon -2674135 true false 150 15 135 30 120 60 120 105 45 165 45 180 120 180 135 240 105 270 120 285 150 270 180 285 195 270 165 240 180 180 255 180 255 165 180 105 180 60 165 30

bullet1
true
0
Circle -7500403 true true 135 135 30
Polygon -7500403 true true 150 165 150 135 150 135 135 150 135 165 165 165 165 150 150 135

bullet2
false
0
Polygon -7500403 true true 150 165 135 150 150 105 165 150 150 165

friedchicken
false
11
Polygon -1 true false 150 0 135 15 120 60 120 105 45 150 45 195 120 180 135 240 105 270 120 285 150 270 180 285 195 270 165 240 180 180 255 195 255 150 180 105 180 60 165 15 150 0
Polygon -1 true false 15 195
Polygon -2674135 true false 135 15 150 15 165 15 150 0 135 15
Polygon -2674135 true false 45 195 75 135 45 150 45 195
Polygon -2674135 true false 255 195 225 135 255 150 255 195
Polygon -1 true false 90 165 150 240 210 165 180 105 150 45 120 105 90 165
Polygon -2674135 true false 135 105 150 45 165 105 165 105 150 135 135 105 135 105
Line -16777216 false 45 195 75 135
Line -16777216 false 45 150 120 105
Line -16777216 false 45 195 45 150
Line -16777216 false 255 195 255 150
Line -16777216 false 180 105 255 150
Line -16777216 false 120 105 120 60
Line -16777216 false 120 60 135 15
Line -16777216 false 135 15 165 15
Line -16777216 false 165 15 180 60
Line -16777216 false 180 60 180 105
Line -16777216 false 150 45 180 105
Line -16777216 false 150 45 150 15
Line -16777216 false 225 135 255 195
Line -16777216 false 150 240 150 270
Line -16777216 false 150 240 210 165
Line -16777216 false 180 105 210 165
Line -16777216 false 90 165 120 105
Polygon -16777216 false false 150 135 135 105 135 105 150 45 165 105 150 135
Line -16777216 false 135 105 150 105
Line -16777216 false 150 105 165 105
Line -16777216 false 165 105 195 135
Line -16777216 false 105 135 135 105
Line -16777216 false 90 165 120 165
Line -16777216 false 180 165 210 165
Polygon -2674135 true false 90 165 120 165 150 240 180 165 210 165 150 135 90 165
Line -16777216 false 90 165 150 135
Line -16777216 false 150 135 210 165
Line -16777216 false 150 240 120 165
Line -16777216 false 150 240 180 165
Polygon -16777216 false false 90 165 90 165 105 180 45 195 105 180
Line -16777216 false 90 165 150 240
Polygon -2674135 true false 45 195 90 165 105 180 45 195
Line -16777216 false 45 195 90 165
Polygon -2674135 true false 195 180 255 195 210 165 195 180
Line -16777216 false 210 165 255 195
Line -16777216 false 195 180 210 165
Line -16777216 false 195 180 255 195
Polygon -2674135 true false 135 240 150 255 150 270 120 285 105 270 135 240
Polygon -2674135 true false 150 255 165 240 195 270 180 285 150 270 150 255
Line -16777216 false 135 240 150 255
Line -16777216 false 150 255 165 240
Line -16777216 false 150 255 150 270
Line -16777216 false 120 255 150 270
Line -16777216 false 150 270 180 255
Polygon -1 true false 105 270 120 255 150 270 120 285 105 270
Polygon -1 true false 150 270 180 285 195 270 180 255 150 270
Line -16777216 false 120 105 150 45

lecheflan
false
1
Polygon -7500403 true false 135 75 60 30 120 45 180 45 240 30 165 75
Polygon -7500403 true false 135 60 120 120 15 105 15 135 120 180 120 240 135 270 150 240 165 270 180 240 180 180 285 135 285 105 180 120 165 60 165 45 135 45 135 60
Polygon -7500403 true false 120 150
Polygon -8630108 true false 135 180 120 135 150 105 180 135 165 180 150 210 135 180
Line -16777216 false 120 195 120 135
Polygon -16777216 true false 135 165
Polygon -16777216 false false 120 135 135 180 150 210 165 180 180 135 150 105 120 135
Line -16777216 false 120 120 150 105
Line -16777216 false 150 105 180 120
Polygon -10899396 true false 15 135 15 105 120 135 120 195 90 165 15 135
Line -16777216 false 15 105 120 135
Polygon -10899396 true false 180 195 180 135 285 105 285 135 210 165 180 195
Line -16777216 false 180 135 285 105
Polygon -16777216 false false 135 180 150 165 165 180
Polygon -16777216 false false 150 165 150 135 165 120 135 120 150 135
Polygon -16777216 false false 150 240 165 270 180 240 180 195
Polygon -16777216 false false 135 225 135 210
Polygon -16777216 false false 150 240 135 270 120 240 120 195
Polygon -7500403 true false 150 225 75 240 120 210 180 210 225 240 150 225
Polygon -8630108 true false 120 195 150 240 180 195 150 210 120 195
Polygon -16777216 false false 120 195 150 240 180 195 150 210 120 195
Polygon -10899396 true false 105 225 75 240 120 225 120 210 75 240
Polygon -10899396 true false 180 210 180 225 225 240 180 210 180 210 225 240
Polygon -16777216 false false 75 240 120 225 120 210 75 240
Polygon -16777216 false false 210 270
Polygon -16777216 false false 180 225 225 240 180 210 180 225
Polygon -10899396 true false 135 60 150 90 135 90 135 105 120 120 135 60
Polygon -10899396 true false 165 60 150 90 165 90 165 105 180 120 165 60
Polygon -16777216 false false 120 120 135 105 135 90 165 90 165 105 180 120
Polygon -16777216 false false 120 120 135 60 135 45 165 45 165 60 180 120
Polygon -16777216 false false 135 60 150 90 165 60
Polygon -16777216 true false 150 225 150 210 150 240
Line -16777216 false 150 240 150 210
Polygon -10899396 true false 150 240 135 270 150 285 165 270 150 240
Polygon -16777216 false false 135 270 150 240 165 270 150 285 135 270
Polygon -10899396 true false 90 45 120 45 60 30 90 45
Polygon -10899396 true false 240 30 180 45 180 45 210 45
Line -16777216 false 60 30 90 45
Line -16777216 false 90 45 120 45
Line -16777216 false 180 45 210 45
Line -16777216 false 210 45 240 30
Line -16777216 false 15 105 15 135
Line -16777216 false 15 135 90 165
Line -16777216 false 210 165 285 135
Line -16777216 false 285 105 285 135
Polygon -7500403 true false 90 165 120 165 120 195 90 165
Polygon -7500403 true false 180 165 210 165 180 195 180 165
Line -16777216 false 180 135 180 195
Line -16777216 false 90 165 90 165
Line -16777216 false 90 165 120 165
Line -16777216 false 180 165 210 165
Line -16777216 false 90 165 120 195
Line -16777216 false 180 195 210 165

moko
false
7
Polygon -1 true false 150 90 255 90 255 75 240 60 240 45 225 30 225 15 195 15 180 30 165 60 165 90 165 90
Polygon -1 true false 105 60 75 90 45 255 60 240 75 255 90 240 120 270 150 255 180 270 210 240 225 255 240 240 255 255 225 90 210 60 165 60
Rectangle -1 true false 90 90 120 120
Polygon -2674135 true false 90 90 45 90 45 75 60 60 60 45 75 30 75 15 105 15 120 30 135 60 135 90 75 90
Polygon -2674135 true false 135 90 240 90 240 75 225 60 225 45 210 30 210 15 195 15 180 30 150 60 150 90 150 90
Rectangle -6459832 true false 135 135 165 150
Rectangle -16777216 true false 135 120 135 150
Rectangle -16777216 true false 120 120 135 150
Rectangle -16777216 true false 165 120 180 150
Rectangle -6459832 true false 135 150 165 165
Rectangle -6459832 true false 120 150 180 165
Rectangle -6459832 true false 90 150 105 165
Rectangle -6459832 true false 195 150 210 165
Rectangle -6459832 true false 120 105 180 120
Rectangle -6459832 true false 105 150 120 165
Rectangle -16777216 true false 105 150 120 165
Rectangle -6459832 true false 105 150 120 165
Rectangle -6459832 true false 180 150 195 165
Rectangle -1 true false 120 180 180 255
Rectangle -16777216 true false 135 270 165 270
Rectangle -16777216 true false 105 255 135 270
Rectangle -16777216 true false 165 255 195 270
Rectangle -16777216 true false 90 225 105 255
Rectangle -2674135 true false 120 240 120 270
Rectangle -2674135 true false 105 225 120 255
Rectangle -2674135 true false 120 225 135 240
Rectangle -2674135 true false 165 240 195 255
Rectangle -2674135 true false 180 225 210 240
Line -16777216 false 180 240 180 225
Rectangle -2674135 true false 120 240 165 255
Line -16777216 false 120 240 120 225
Line -16777216 false 120 240 180 240
Rectangle -2674135 true false 165 225 180 240
Rectangle -16777216 true false 165 165 210 180
Rectangle -16777216 true false 90 165 135 180
Rectangle -16777216 true false 75 180 90 210
Rectangle -16777216 true false 90 210 105 225
Rectangle -16777216 true false 105 210 135 225
Rectangle -16777216 true false 210 180 225 210
Rectangle -16777216 true false 165 210 210 225
Rectangle -16777216 true false 135 195 135 225
Rectangle -16777216 true false 120 180 135 210
Rectangle -16777216 true false 165 180 180 210
Rectangle -1 true false 90 180 120 210
Rectangle -1 true false 180 180 210 210
Rectangle -7500403 true false 90 195 120 210
Rectangle -7500403 true false 180 195 210 210
Rectangle -7500403 true false 135 225 165 240
Rectangle -6459832 true false 120 75 180 105
Rectangle -1 true false 180 90 210 120
Rectangle -1 true false 90 75 120 90
Rectangle -16777216 true false 135 240 165 255
Rectangle -16777216 true false 195 225 210 255
Rectangle -6459832 true false 90 105 120 150
Rectangle -6459832 true false 180 105 210 150
Rectangle -6459832 true false 120 165 180 180
Polygon -1 true false 105 90 60 90 60 75 75 60 75 45 90 30 90 15 105 15 135 45 150 60 150 90 90 90
Polygon -2674135 true false 120 90 75 90 75 75 90 60 90 45 105 30 105 15 105 15 135 45 165 60 165 90 90 90
Rectangle -1 true false 105 60 195 90
Rectangle -1 true false 120 45 180 60
Rectangle -1 true false 90 75 105 90
Rectangle -1 true false 195 75 210 90
Rectangle -6459832 true false 135 105 165 135

mokobulleta
true
0
Rectangle -7500403 true true 105 90 195 195
Rectangle -1 true false 120 105 180 180
Polygon -7500403 false true 135 120 165 120 135 165 165 165 165 120 135 120 135 135 150 150 150 150

mokobulletb
true
0
Circle -2674135 true false 83 83 134
Circle -1 true false 96 96 108
Circle -2674135 true false 116 116 67
Circle -1 true false 129 129 42

mokobulletc
true
0
Circle -8630108 true false 83 83 134
Circle -16777216 true false 96 96 108
Circle -8630108 true false 116 116 67
Circle -16777216 true false 129 129 42

mokobulletd
true
0
Circle -2064490 true false 83 83 134
Circle -5825686 true false 96 96 108
Circle -2064490 true false 116 116 67
Circle -5825686 true false 129 129 42

spawner
false
3
Polygon -2064490 false false 135 165 135 135 165 135 165 150 135 150 135 165 135 135 165 135 165 150 135 150
Line -2064490 false 135 165 135 165
Rectangle -16777216 true false 120 120 180 180

vu-1
false
0
Polygon -14835848 true false 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 195 105 150 105 105 105 60 105 15 120 0 135
Polygon -16777216 false false 105 105 60 105 15 120 0 135 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 210 105
Polygon -8630108 true false 60 131 90 161 135 176 165 176 210 161 240 131 225 101 195 71 150 60 105 71 75 101
Circle -16777216 false false 255 135 30
Circle -16777216 false false 180 180 30
Circle -16777216 false false 90 180 30
Circle -16777216 false false 15 135 30
Circle -8630108 true false 15 135 30
Circle -8630108 true false 90 180 30
Circle -8630108 true false 180 180 30
Circle -8630108 true false 255 135 30
Polygon -16777216 false false 150 60 105 70 75 100 60 130 90 160 135 175 165 175 210 160 240 130 225 105 195 70

vx-1
false
1
Polygon -7500403 true false 180 75 195 105 180 150 180 195 165 225 150 240 135 225 120 195 120 150 105 105 120 75 135 30 165 30 180 75
Polygon -7500403 true false 180 120 225 90 240 45 210 45 210 60 180 60 90 60 90 45 60 45 75 90 120 120
Polygon -7500403 true false 165 195 150 210
Polygon -2674135 true true 165 150 165 180 150 210 135 180 135 150 150 120 165 150
Polygon -2674135 true true 90 60 105 75 105 60 120 75 120 60
Polygon -16777216 false false 210 60 195 75 195 60 180 75 180 60 210 60 150 120 90 60 105 60 105 75 105 60 120 60 120 75 105 60 120 60 150 30 180 60
Polygon -2674135 true true 210 60 195 75 195 60 180 75 180 60 210 60
Polygon -14835848 true false 195 60 195 75 150 120 105 75 105 60 120 75 120 60 150 30 180 60 180 75 195 60
Polygon -16777216 false false 210 60 195 75 195 60 180 75 180 60 210 60 150 120
Polygon -16777216 false false 180 60 150 30 120 60 120 75 105 60 105 75 150 120 90 60
Polygon -16777216 false false 150 180 150 120
Line -16777216 false 75 90 90 45
Line -16777216 false 225 90 210 45
Line -16777216 false 225 90 150 120
Line -16777216 false 75 90 150 120
Polygon -14835848 true false 180 135 180 135 150 120 165 150 180 135
Polygon -16777216 false false 165 150 150 120 135 150 135 180 150 210 165 180 165 150
Polygon -14835848 true false 150 120 135 150 120 135 150 120
Polygon -16777216 false false 180 135 150 120 120 135 135 150 150 120 165 150 180 135
Polygon -14835848 true false 180 195 165 195 150 225 165 225 180 195
Polygon -14835848 true false 150 225 135 195 120 195 135 225 150 225
Polygon -14835848 true false 225 45 225 90 240 45 225 45
Polygon -14835848 true false 75 45 75 90 60 45 75 45
Polygon -16777216 false false 240 45 225 45 225 90 240 45
Polygon -16777216 false false 90 45 60 45 75 90 75 45
Polygon -16777216 false false 180 195 165 195 150 225 135 195 120 195 135 225 150 225 165 225 180 195
Line -16777216 false 150 225 150 240
Line -16777216 false 165 180 165 195
Line -16777216 false 150 210 150 225
Line -16777216 false 135 180 135 195
Line -16777216 false 120 150 120 135
Line -16777216 false 150 180 165 180
Line -16777216 false 135 180 150 180
Line -16777216 false 180 135 180 150

vx-2
false
1
Polygon -7500403 true false 120 195 45 165 30 135 15 105 120 120 150 75 180 120 285 105 270 135 255 165 180 195 180 240 165 255 135 255 120 240 120 195
Polygon -14835848 true false 180 120 255 165 270 135 180 120
Polygon -7500403 true false 135 195 165 180
Polygon -2674135 true true 135 225 135 195 150 165 165 195 165 225 150 240 135 225
Polygon -14835848 true false 30 135 45 165 120 120 30 135
Polygon -16777216 false false 45 165 150 165 255 165 180 120 120 120 45 165 15 105 120 120 180 120 285 105 255 165
Line -16777216 false 135 255 150 240
Line -16777216 false 150 240 165 255
Line -16777216 false 120 120 150 105
Line -16777216 false 150 105 180 120
Line -16777216 false 150 90 150 105
Line -16777216 false 150 90 150 75
Polygon -2674135 true true 120 120 150 90 150 105 120 120
Line -16777216 false 150 90 120 120
Line -16777216 false 150 90 180 120
Polygon -2674135 true true 150 105 180 120 150 90 150 105
Line -16777216 false 150 105 150 90
Polygon -14835848 true false 120 120 150 75 150 90 120 120
Polygon -14835848 true false 150 90 180 120 150 75 150 105
Polygon -16777216 false false 120 120 150 75 150 90 180 120 150 75
Line -16777216 false 150 90 120 120
Line -16777216 false 120 195 150 165
Line -16777216 false 150 165 180 195
Polygon -14835848 true false 120 240 135 255 150 240 135 225 120 240
Polygon -14835848 true false 150 240 165 255 180 240 165 225 150 240
Line -16777216 false 120 240 135 225
Line -16777216 false 165 225 180 240
Polygon -16777216 false false 135 225 135 195 150 165 165 195 165 225 150 240 135 225
Polygon -14835848 true false 135 255 150 270 165 255 135 255
Line -16777216 false 30 135 120 120
Line -16777216 false 270 135 180 120
Polygon -7500403 true false 15 105
Polygon -16777216 false false 120 210 135 195 165 195 180 210 165 225 135 225 120 210
Polygon -16777216 false false 120 120 150 165 180 120
Line -16777216 false 135 255 165 255
Polygon -16777216 false false 165 255 135 255 150 270 165 255

vx-3
false
1
Polygon -7500403 true false 135 60 120 120 15 105 15 135 120 195 120 240 135 270 150 240 165 270 180 240 180 195 285 135 285 105 180 120 165 60 165 45 135 45 135 60
Polygon -7500403 true false 120 150
Polygon -2674135 true true 135 180 120 135 150 105 180 135 165 180 150 210 135 180
Line -16777216 false 120 195 120 135
Polygon -16777216 true false 135 165
Polygon -16777216 false false 120 135 135 180 150 210 165 180 180 135 150 105 120 135
Line -16777216 false 120 120 150 105
Line -16777216 false 150 105 180 120
Polygon -14835848 true false 15 135 15 105 120 135 120 195 90 165 15 135
Line -16777216 false 15 105 120 135
Polygon -16777216 false false 15 135 90 165 120 195
Polygon -14835848 true false 180 195 180 135 285 105 285 135 210 165 180 195
Line -16777216 false 180 135 285 105
Line -16777216 false 180 135 180 195
Polygon -16777216 false false 180 195 210 165 285 135
Polygon -16777216 false false 135 180 150 165 165 180
Polygon -16777216 false false 150 165 150 135 165 120 135 120 150 135
Polygon -16777216 false false 150 240 165 270 180 240 180 195
Polygon -16777216 false false 135 225 135 210
Polygon -16777216 false false 150 240 135 270 120 240 120 195
Polygon -7500403 true false 150 225 75 240 120 210 180 210 225 240 150 225
Polygon -2674135 true true 120 195 150 240 180 195 150 210 120 195
Polygon -16777216 false false 120 195 150 240 180 195 150 210 120 195
Polygon -14835848 true false 105 225 75 240 120 225 120 210 75 240
Polygon -14835848 true false 180 210 180 225 225 240 180 210 180 210 225 240
Polygon -16777216 false false 75 240 120 225 120 210 75 240
Polygon -16777216 false false 210 270
Polygon -16777216 false false 180 225 225 240 180 210 180 225
Polygon -14835848 true false 135 60 150 90 135 90 135 105 120 120 135 60
Polygon -14835848 true false 165 60 150 90 165 90 165 105 180 120 165 60
Polygon -16777216 false false 120 120 135 105 135 90 165 90 165 105 180 120
Polygon -16777216 false false 120 120 135 60 135 45 165 45 165 60 180 120
Polygon -16777216 false false 135 60 150 90 165 60
Polygon -16777216 true false 150 225 150 210 150 240
Line -16777216 false 150 240 150 210
@#$#@#$#@
NetLogo 6.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
