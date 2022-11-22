
## Warning
This was written whilst I was learning to code and the whole thing needs a re-write 😆 It's not a reflection of my current programming ability but I'm leaving this on here as I was chuffed with this project when I first completed it. 

# Chess

A final project completed as part of the The Odin Projects Ruby Course.

![ezgif-3-3e23bc000c0f](https://user-images.githubusercontent.com/47796704/111031271-8a4a7780-83fe-11eb-8eae-23663cbd8df0.gif)

Features: 
- Block illegal moves
- Show correct error messages 
- Easily differentiate between chess board pieces 
- Board remains fixed just the pieces update in the command line
- Declare check or checkmate
- Save/load

## How To Play

### Setup

1. Clone this repo in your command line: `git clone git@github.com:crobbo/chess-game-final-project.git`

2. Navigate to the `chess-game-final-project` directory.

3. Start a game by typing `ruby lib/main.rb`

### Gameplay

* Choose whether to load a previous game
* Follow the onscreen instructions
* The game uses a traditional chess coordinate system to select and move pieces. 
* Type start and finish squares together, e.g. type 'a2a4' and press enter to move from square 'a2' to 'a4'
* If the move is valid the Piece will be moved
* If move not valid, game will ask to to re-enter your choice until a valid move is chosen by player.
* Game continues until Checkmate is reached 
* To Castle pieces, player can type the string 'castle'

### Saving and Loading Game

* Type 'save' at any time to Save Game & Exit
* To load, start game using `ruby lib/main.rb` & enter `Y`
* Select which game to load by entering the corresponding number 


### Improvements 

* Integrate computer AI
* Re-factor code & make the code more modular. 
