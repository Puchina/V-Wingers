# V-Wingers
## Netlogo version (6.1.0)

## Overview
This NetLogo model is inspired by bullet hell games and space shooter games. The goal is to defeat the Boss at the top of the screen while maneuvering through an endless wave of projectiles.

## How It Works
- The Boss, with a certain amount of HP, unleashes new projectiles as its health decreases.
- Players must navigate to safer zones to avoid projectiles or face new enemies spawned by the Boss.
- Win by reducing the Boss's HP to 0; lose if player lives reach 0 (initially given three lives).

## Usage
### Buttons
- **NEW GAME:** Resets the game
- **START:** Begins the game
- **Direction buttons (UP, DOWN, LEFT, RIGHT):** Moves the player in the corresponding direction
- **FIRE:** Shoots projectiles

### Monitor
- **PLAYER LIVES:** Displays remaining lives
- **ENEMY BOSS HP:** Shows remaining health points of the enemy Boss
- **CURRENT LEVEL:** Monitors the current level
- **SCORE:** Displays the current score in the current level

### Sliders
- **START-LEVEL:** Selects the level to start with

## Cast of Characters
- **Fried Chicken:** Player character piloting the red-white plane.
- **Cookie:** Tutorial boss in the first level, a UFO-like enemy.
- **LecheFlan:** Second level boss, identified by its green-purple color scheme.
- **VX-Ship Series:** LecheFlan's goons in the second level.
- **Moko:** Third level enemy, a parody character from Touhou Project based on Fujiwara Mokou.

## Things to Notice
- Hitting the wing of the plane doesn't deal damage; target the cockpit to destroy opponents.
- Each level introduces new challenges and enemy types with different attack patterns.

## Things to Try
- Beat your highest score.
- Win without losing a single life.
- After defeating the first level boss, take out the second boss!

## Extending the Model
Consider implementing:
- Temporary invincibility after getting hit.
- Power-ups.
- New Boss with different gimmicks.
- Additional enemies with unique behaviors.
- Diverse projectile patterns.

## NetLogo Features
This model utilizes breeds, random, globals, and user-message.

## Related Models
- [Frogger](http://ccl.northwestern.edu/netlogo/models/Frogger): For movement and check/die functionality.
- [Projectile Attack](http://ccl.northwestern.edu/netlogo/models/ProjectileAttack): For the fire button and projectiles.
- [Pacman](http://ccl.northwestern.edu/netlogo/models/Pac-Man): For level-related features.

## Credits and References
### Related Models
- **Frogger:**
  - Wilensky, U. (2002). NetLogo Frogger model. [Link](http://ccl.northwestern.edu/netlogo/models/Frogger).
- **Projectile Attack:**
  - Wilensky, U. (2008). NetLogo Projectile Attack model. [Link](http://ccl.northwestern.edu/netlogo/models/ProjectileAttack).
- **Pacman:**
  - Wilensky, U. (2001). NetLogo Pac-Man model. [Link](http://ccl.northwestern.edu/netlogo/models/Pac-Man).

### This Model
If you mention or adapt this model, please include the citation below.
- Lance (2019). NetLogo V-Wingers.