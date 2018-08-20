# Project Title: 
 
```
ReDesigned MOBA
```

## Project Idea: 
 
```
The classic Pacman game simulated with a few modifications. The player controls Pac-Man through a
'maze' of various dots, known as Pac-Dots or pellets. There are also four multi-colored ghosts:
Blinky (red), Pinky (pink), Inky (blue), and Clyde (orange). In many versions, each ghost has its
own personality (which we chose to skip because it would require many more levels to truly see it),
however, we kept the 'ghost pen' in the middle the same. The goal of the game is to consume all the
pellets in a level in order to proceed to the next one (however, we chose to display a game won
screen instead because during a demo we wouldn't be able to show the levels and also time restraints). 
The four ghosts roam the 'maze', trying to catch Pacman. If any of the ghosts touch Pacman, he  loses 
a life and the game 'resets' in the sense that the eaten pellets are still eaten and the score remains 
the same. The 'reset' is moving all characters back to original starting positions. When all lives have 
been lost, the game ends. Pacman is awarded a single bonus life at 10,000 points by default—DIP switches
inside the machine (in arcades) can change the required points to 15,000 or 20,000 ,or disable the bonus 
life altogether (we have disabled this for the time being).
```

### IMPORTANT NOTES/ INSTRUCTIONS:
```
   -run "processing main.pde", and run using processing interface to start game
   -the map was already changed from 1024 x 1024 to 600 x 512, please have a screen that can support 600 x 512
   -use arrow keys to move (have keyboard with arrow keys! or remap your keyboard, or use on screen keyboard)
   -'touch' will mean to click on screen (have a pointer device (eg mouse, touch pad, tablet) or remap a key 
    to act like a one)
   -sometimes when first running the file, you may have to click on the processing screen in order for it to 
    register movements
```

### WORKING FEATURES / THINGS FOR MR. K TO TEST:
```
   -Player (Pacman)
    -Movement (cardinal directions)
    -Score
     -eating pellets add 200 to score
      -moving to a spot without a pellet or already eaten pellet won't increase score
     -eating ghosts will add a greater score than the eating the 'pellets' (specicially 500 points)
    -Power Up
     -Allow player to 'eat' ghosts
      -without this, player dies if in contact with ghost
   -Ghost AI
    -Multiple states
     -'chase' -- literally go after the player. note that the different paths can lead to an ambush/ cornering
     -'scatter' -- modern games are somewhat random movement, but generally they aim for a corner of the board (we mimicked the orginal)
     -'frightened' -- basically they can be eaten, turn blue-ish
```

### DEBUGS FOR TESTING PURPOSE (FOR MR.K'S CONVENIENCE):
```
   -Press 'a'
    -Makes Pacman speed normal
   -Press 's'
    -Makes Pacman speed super fast (1000/3 times faster than normal)
   -Press 'd'
    -Makes Pacman speed super slow (1/3 times slower than normal)
   -Press 'z'
    -Makes ghosts change to 'frightened' state
   -Press 'x'
    -Makes ghosts revert to an 'un-frightened' state(scattering or chasing depending on time)
```

### UNRESOLVED BUGS / UNIMPLEMENTED FEATURES:
```
   -Player (Pacman)
    -Player is slighly slower than ghosts, if ghosts revert to 'chase' nearby, they may overcome Pacman
    -if player is smart, he can outthink the AI and accurately predict movements to the extent of winning at 'chicken'
   -Ghosts
    -'frightened' Blinky looks weird
    -Ghosts' changes between states sometimes look un-natural, especially when they are in 'scattering'
    -Player can 'camp' near the 'ghost pen' if they were to eat a power up every so often (power ups last by time increments)
   -More maps!
   -Increasing player lives (3/4 is already pretty overkill for one level)
 ```
