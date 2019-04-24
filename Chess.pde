/*
 To-do:
 ***Create a class or something for all pieces, in order to not have to write all pieces in the moveChecker function.
 
 **Add En Passant (hard) and Towering (easier).
 **Make it illegal to move when in check.
 
 *Make it possible to back-up more than one turn.
 
 Add win-message.
 Allow to pick what piece to promote to, and remove Amazon piece (it's hella OP).
 Add gamemodes, eg Fairy chess.
 */



static PImage wKing, bKing, wQueen, bQueen, wPawn, bPawn, wRook, bRook, wKnight, bKnight, wBishop, bBishop, wAmazon, bAmazon;
PImage[][] board, prevBoard;
boolean gameOver = false; //Not in use right now. Future use is to check if the king has been taken, in order to start over game.

boolean clicked; //Checks whether it's the first time you click a piece or not.

static int turn; //Black's turn if even, white's turn if odd.
boolean isStarted; //Just used to be able to make the first piece selected be highlighted in blue.

int y1, x1, y2, x2; //Coordinates for selected squares. For some reason in the logic of (y, x); sorry about that. '1' is the selected square, '2' is the square you want to move to.

void settings() {
  size(640, 640);
}

void setup() {
  surface.setResizable(true); //Window is resizeable, but it messes with the proportions.
  noStroke();

  wKing = loadImage("pieces/king1.png");
  bKing = loadImage("pieces/king2.png");
  wQueen = loadImage("pieces/queen1.png");
  bQueen = loadImage("pieces/queen2.png");
  wPawn = loadImage("pieces/pawn1.png");
  bPawn = loadImage("pieces/pawn2.png");
  wRook = loadImage("pieces/rook1.png");
  bRook = loadImage("pieces/rook2.png");
  wKnight = loadImage("pieces/knight1.png");
  bKnight = loadImage("pieces/knight2.png");
  wBishop = loadImage("pieces/bishop1.png");
  bBishop = loadImage("pieces/bishop2.png"); //https://commons.wikimedia.org/wiki/Category:PNG_chess_pieces/Standard_transparent
  wAmazon = loadImage("pieces/amazon1.png");
  bAmazon = loadImage("pieces/amazon2.png");
  wKing.resize(width/8, height/8);
  bKing.resize(width/8, height/8);
  wQueen.resize(width/8, height/8);
  bQueen.resize(width/8, height/8);
  wPawn.resize(width/8, height/8);
  bPawn.resize(width/8, height/8);
  wRook.resize(width/8, height/8);  
  bRook.resize(width/8, height/8); 
  wKnight.resize(width/8, height/8);
  bKnight.resize(width/8, height/8);
  wBishop.resize(width/8, height/8);  
  bBishop.resize(width/8, height/8);
  wAmazon.resize(width/8, height/8);
  bAmazon.resize(width/8, height/8);
  startPosition();
  
  surface.setIcon(wPawn);
  surface.setTitle("Chess"); 
  
}

void draw() {
  showBoard(); //Most of the game is driven by the mousePressed() function, which is auto-called.
}

void showBoard() {
  if (keyPressed) {
    if (key == ENTER || key == RETURN) { //Move back one move if enter/return is pressed.
      board = prevBoard;
      turn--;
    }
  }
  for (int i = 0; i<8; i++) {
    for (int j = 0; j<8; j++) { 
      if ((i+j)%2 == 0) fill(255, 206, 158); //Checkered board.
      else fill(209, 139, 71);
      rect(i*width/8, j*height/8, width/8, height/8);//Board
      if (board[j][i] != null) image(board[j][i], i*width/8, j*height/8);//Pieces
      if (j == y1 && i == x1 && board[j][i] != null && isStarted) {
        fill(0, 0, 255, 100);//Highlight selected piece in blue.
        rect(i*width/8, j*height/8, width/8, height/8);
      }
      if (Rules.moveChecker(y1, x1, j, i, board) && isStarted) {
        fill(255, 0, 0, 100);//Highlight possible moves in red.
        rect(i*width/8, j*height/8, width/8, height/8);
      }
    }
  }
  noStroke();
}

void startPosition() {
  board = new PImage[8][8];
  prevBoard = new PImage[8][8];

  board[0][0] = bRook;
  board[0][1] = bKnight;
  board[0][2] = bBishop;
  board[0][3] = bQueen;
  board[0][4] = bKing;
  board[0][5] = bBishop;
  board[0][6] = bKnight;
  board[0][7] = bRook;
  board[1][0] = bPawn;
  board[1][1] = bPawn;
  board[1][2] = bPawn; 
  board[1][3] = bPawn;
  board[1][4] = bPawn;
  board[1][5] = bPawn;
  board[1][6] = bPawn;
  board[1][7] = bPawn;

  board[7][0] = wRook;
  board[7][1] = wKnight;
  board[7][2] = wBishop;
  board[7][3] = wQueen;
  board[7][4] = wKing;
  board[7][5] = wBishop;
  board[7][6] = wKnight;
  board[7][7] = wRook;
  board[6][0] = wPawn;
  board[6][1] = wPawn;
  board[6][2] = wPawn;
  board[6][3] = wPawn;
  board[6][4] = wPawn;
  board[6][5] = wPawn;
  board[6][6] = wPawn;
  board[6][7] = wPawn;

  //Variable declarations:
  clicked = false;
  turn = 1;
  isStarted = false;
}


void mousePressed() {
  if (clicked) {
    y2 = round(mouseY / (height/8)-0.5);
    x2 = round(mouseX / (width/8)-0.5);
    if (Rules.moveChecker(y1, x1, y2, x2, board)) {
      //Following 2 if-statements are auto-promotions, if the move is a Pawn that has reached the other side. It promotes to an Amazon, an over powered "fairy" piece. An easter egg ;)
      if (board[y1][x1] == wPawn && y2 == 0) {
        prevBoard = Board.boardSaver(board);
        board[y2][x2] = wAmazon;
        board[y1][x1] = null;
      } else if (board[y1][x1] == bPawn && y2 == 7) {
        prevBoard = Board.boardSaver(board); 
        board[y2][x2] = bAmazon;
        board[y1][x1] = null;
      } else {
        prevBoard = Board.boardSaver(board); //Save the current round as a temp if a mistake is made, in order to allow for backing.
        board = Board.movePiece(y1, x1, y2, x2, board);
      }
      clicked = false;
      turn++;
    } else { //if the move wasn't legal, the new square will be treated as if first selected.
      y1 = y2;
      x1 = x2;
      clicked = true;
    }
  } else {
    y1 = round(mouseY / (height/8)-0.5);
    x1 = round(mouseX / (width/8)-0.5);
    clicked = true;
    isStarted = true;
  }
}
