static class Board { //Made into a class in order to gather functions that "check the board".

  static boolean obstructionChecker(int y1, int x1, int y2, int x2, PImage[][] board) {
    boolean isObstructed = false;
    /*
     This function checks if a move from a Queen, Bishop or Rook is obstructed by another piece. 
     First it checks the direction of the move, then enters a for-loop, where the amount of iterations
     is equal to the amount of squares between the starting position and the ending positions. It controls 
     if any of these squares have a piece in them (!null), and returns isObstructed if it has.
     */
    if (x1 == x2 && y1 > y2) {//The move is vertical, going up.
      for (int i = 1; i<(y1-y2); i++) {
        if (board[y1-i][x1] != null) isObstructed = true;
      }
    }
    if (x1 == x2 && y1 < y2) {//The move is vertical, going down.
      for (int i = 1; i<(y2-y1); i++) {
        if (board[y1+i][x1] != null) isObstructed = true;
      }
    }

    if (y1 == y2 && x1 < x2) { //The move is horizontal, going right.
      for (int i = 1; i<(x2-x1); i++) {
        if (board[y1][x1+i] != null) isObstructed = true;
      }
    }
    if (y1 == y2 && x1 > x2) {//The move is horizontal, going left.
      for (int i = 1; i<(x1-x2); i++) {
        if (board[y1][x1-i] != null) isObstructed = true;
      }
    }

    if (y1 - y2 == x1 - x2 && y1 > y2) { //The move is diagonal, going up to the left.
      for (int i = 1; i<(x1-x2); i++) {
        if (board[y1-i][x1-i] != null) isObstructed = true;
      }
    }
    if (y1 - y2 == x1 - x2 && y1 < y2) { //The move is diagonal, going down to the right.
      for (int i = 1; i<(x2-x1); i++) {
        if (board[y1+i][x1+i] != null) isObstructed = true;
      }
    }

    if (y1 - y2 == x2 - x1 && y1 > y2) { //The move is diagonal, going up to the right. 
      for (int i = 1; i<(x2-x1); i++) {
        if (board[y1-i][x1+i] != null) isObstructed = true;
      }
    }
    if (y1 - y2 == x2 - x1 && y1 < y2) { //The move is diagonal, going down to the left.
      for (int i = 1; i<(x1-x2); i++) {
        if (board[y1+i][x1-i] != null) isObstructed = true;
      }
    }
    return isObstructed;
  }



  //Had to be made into a function for it to work more than once. Don't know why really.
  //Saves the current board each round in order to allow for back-up. Majorly buggy.
  static PImage[][] boardSaver(PImage[][] board) { 
    PImage[][] transferBoard = new PImage[8][8];
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        transferBoard[j][i] = board[j][i];
      }
    }   
    return transferBoard;
  }

  //Function for moving pieces from x1,y1 to x2,y2.
  static PImage[][] movePiece(int y1, int x1, int y2, int x2, PImage[][] board) {
    board[y2][x2] = board[y1][x1]; //Move the piece of the first selected square to the square selected thereafter.
    board[y1][x1] = null; //Empty the first square.
    return board;
  }
}
