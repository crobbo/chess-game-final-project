# Chess

A final project completed as part of the The Odin Projects Ruby Course.

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
* The game uses a numbered coordinate system to select and move pieces
* Enter X and Y coordinate of the peice you wish to move 
* Enter X and Y cooridnate of the square you intend to move to
* If the move is valid the Piece will be moved
* Game continues until Checkmate is reached 

### Saving and Loading Game

* Type 'save' at any time to Save Game & Exit
* To load, start game using `ruby lib/main.rb` & enter `Y`
* Select which game to load by entering the corresponding number 


### Improvements 

* Integrate computer AI
* Improve UI of gameplay / board
