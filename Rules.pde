static class Rules {
  static boolean moveChecker(int y1, int x1, int y2, int x2, PImage[][] board) {
    //Checks if the moves are legal using absolute values to check both negative and positive values. Can probably be made less messy.
    boolean legalMove = false;

    //-----------------------------------------------Pawn-----------------------------------------------
    boolean squareFilled = false;
    //Check if the move is a diagonal attack:
    if (board[y1][x1] == bPawn && turn%2 == 0) {
      if (board[y2][x2] == wPawn || 
        board[y2][x2] == wAmazon ||
        board[y2][x2] == wBishop || 
        board[y2][x2] == wKing || 
        board[y2][x2] == wQueen || 
        board[y2][x2] == wKnight || 
        board[y2][x2] == wRook) {
        if (abs(x2-x1)==1 && y2-y1 == 1) legalMove = true;
      }
    }
    if (board[y1][x1] == wPawn && turn%2 == 1) {
      if (board[y2][x2] == bPawn || 
        board[y2][x2] == bAmazon ||
        board[y2][x2] == bBishop || 
        board[y2][x2] == bKing || 
        board[y2][x2] == bQueen || 
        board[y2][x2] == bKnight || 
        board[y2][x2] == bRook) {
        if (abs(x2-x1)==1 && y2-y1 == -1) legalMove = true;
      }
    }
    //Check if the move is obstructed:
    if (board[y2][x2] != null) squareFilled = true;
    if (!squareFilled) {
      if (board[y1][x1] == bPawn && turn%2 == 0) {
        if (y1 == 1 && board[y1+1][x1] == null) { //allow for double-step if the black pawn hasn't moved yet
          if (y2 - y1 == 2 && x1 == x2 || y2 - y1 == 1 && x1 == x2) legalMove = true;
        } else if (y2 - y1 == 1 && x1 == x2) legalMove = true; //basic 1-step move
      }
      if (board[y1][x1] == wPawn && turn%2 == 1) {
        if (y1 == 6 && board[y1-1][x1] == null) { //allow for double-step if the white pawn hasn't moved yet
          if (y2 - y1 == -2 && x1 == x2 || y2 - y1 == -1 && x1 == x2) legalMove = true;
        } else if (y2 - y1 == -1 && x1 == x2) legalMove = true; //basic 1-step move
      }
    }
    //-----------------------------------------------end of Pawn-----------------------------------------------
    //-----------------------------------------------Knight & Amazon:-----------------------------------------------
    if (board[y1][x1] == bKnight && turn%2 == 0 || board[y1][x1] == bAmazon && turn%2 == 0) {
      if (board[y2][x2] == wPawn || 
        board[y2][x2] == wBishop || 
        board[y2][x2] == wKing || 
        board[y2][x2] == wQueen || 
        board[y2][x2] == wKnight || 
        board[y2][x2] == wRook ||
        board[y2][x2] == wAmazon ||
        board[y2][x2] == null) { //Make sure that the attacked square isn't a friendly piece.
        if (abs(x1-x2) == 1 && abs(y1-y2) == 2) { //Absolute values are used since the moves are symmetrical. Same goes for all other pieces.
          legalMove = true;
        } else if (abs(x1-x2) == 2 && abs(y1-y2) == 1) {
          legalMove = true;
        }
      }
    }
    if (board[y1][x1] == wKnight && turn%2 == 1 || board[y1][x1] == wAmazon && turn%2 == 1) {
      if (board[y2][x2] == bPawn || 
        board[y2][x2] == bBishop || 
        board[y2][x2] == bKing || 
        board[y2][x2] == bQueen || 
        board[y2][x2] == bKnight || 
        board[y2][x2] == bRook ||
        board[y2][x2] == bAmazon ||
        board[y2][x2] == null) {
        if (abs(x1-x2) == 1 && abs(y1-y2) == 2) {
          legalMove = true;
        } else if (abs(x1-x2) == 2 && abs(y1-y2) == 1) {
          legalMove = true;
        }
      }
    }
    //-----------------------------------------------end of Knight & Amazon-----------------------------------------------
    //-----------------------------------------------King:-----------------------------------------------
    if (board[y1][x1] == bKing && turn%2 == 0) {
      if (board[y2][x2] == wPawn || 
        board[y2][x2] == wBishop || 
        board[y2][x2] == wKing || 
        board[y2][x2] == wQueen || 
        board[y2][x2] == wKnight || 
        board[y2][x2] == wRook ||
        board[y2][x2] == wAmazon ||
        board[y2][x2] == null) {
        if (x1 == x2 && abs(y1-y2) == 1) legalMove = true;
        if (abs(x1-x2) == 1 && y1 == y2) legalMove = true;
        if (abs(x1-x2) == 1 && abs(y1-y2) == 1) legalMove = true;
      }
    }
    if (board[y1][x1] == wKing && turn%2 == 1) {
      if (board[y2][x2] == bPawn || 
        board[y2][x2] == bBishop || 
        board[y2][x2] == bKing || 
        board[y2][x2] == bQueen || 
        board[y2][x2] == bKnight || 
        board[y2][x2] == bRook ||
        board[y2][x2] == bAmazon ||
        board[y2][x2] == null) {
        if (x1 == x2 && abs(y1-y2) == 1) legalMove = true;
        if (abs(x1-x2) == 1 && y1 == y2) legalMove = true;
        if (abs(x1-x2) == 1 && abs(y1-y2) == 1) legalMove = true;
      }
    }
    //-----------------------------------------------end of King-----------------------------------------------
    //-----------------------------------------------Rook:-----------------------------------------------
    if (!Board.obstructionChecker(y1, x1, y2, x2, board)) {
      if (board[y1][x1] == bRook && turn%2 == 0) {
        if (board[y2][x2] == wPawn || 
          board[y2][x2] == wBishop || 
          board[y2][x2] == wKing || 
          board[y2][x2] == wQueen || 
          board[y2][x2] == wKnight || 
          board[y2][x2] == wRook ||
          board[y2][x2] == wAmazon ||
          board[y2][x2] == null) {
          if (x1 == x2 || y1 == y2) legalMove = true;
        }
      }
      if (board[y1][x1] == wRook && turn%2 == 1) {
        if (board[y2][x2] == bPawn || 
          board[y2][x2] == bBishop || 
          board[y2][x2] == bKing || 
          board[y2][x2] == bQueen || 
          board[y2][x2] == bKnight || 
          board[y2][x2] == bRook ||
          board[y2][x2] == bAmazon ||
          board[y2][x2] == null) {
          if (x1 == x2 || y1 == y2) legalMove = true;
        }
      }
    }
    //-----------------------------------------------end of Rook-----------------------------------------------
    //-----------------------------------------------Bishop:-----------------------------------------------
    if (!Board.obstructionChecker(y1, x1, y2, x2, board)) {
      if (board[y1][x1] == bBishop && turn%2 == 0) {
        if (board[y2][x2] == wPawn || 
          board[y2][x2] == wBishop || 
          board[y2][x2] == wKing || 
          board[y2][x2] == wQueen || 
          board[y2][x2] == wKnight || 
          board[y2][x2] == wRook ||
          board[y2][x2] == wAmazon ||
          board[y2][x2] == null) {
          if (abs(x1 - x2) == abs(y1 - y2)) legalMove = true;
        }
      }
      if (board[y1][x1] == wBishop && turn%2 == 1) {
        if (board[y2][x2] == bPawn || 
          board[y2][x2] == bBishop || 
          board[y2][x2] == bKing || 
          board[y2][x2] == bQueen || 
          board[y2][x2] == bKnight || 
          board[y2][x2] == bRook ||
          board[y2][x2] == bAmazon ||
          board[y2][x2] == null) {
          if (abs(x1 - x2) == abs(y1 - y2)) legalMove = true;
        }
      }
    }
    //-----------------------------------------------end of Bishop-----------------------------------------------
    //-----------------------------------------------Queen & Amazon:-----------------------------------------------
    if (!Board.obstructionChecker(y1, x1, y2, x2, board)) {
      if (board[y1][x1] == bQueen  && turn%2 == 0 || board[y1][x1] == bAmazon && turn%2 == 0) {
        if (board[y2][x2] == wPawn || 
          board[y2][x2] == wBishop || 
          board[y2][x2] == wKing || 
          board[y2][x2] == wQueen || 
          board[y2][x2] == wKnight || 
          board[y2][x2] == wRook ||
          board[y2][x2] == wAmazon ||
          board[y2][x2] == null) {
          if (abs(x1 - x2) == abs(y1 - y2) || x1 == x2 || y1 == y2) legalMove = true;
        }
      }
      if (board[y1][x1] == wQueen  && turn%2 == 1 || board[y1][x1] == wAmazon && turn%2 == 1) {
        if (board[y2][x2] == bPawn || 
          board[y2][x2] == bBishop || 
          board[y2][x2] == bKing || 
          board[y2][x2] == bQueen || 
          board[y2][x2] == bKnight || 
          board[y2][x2] == bRook ||
          board[y2][x2] == bAmazon ||
          board[y2][x2] == null) {
          if (abs(x1 - x2) == abs(y1 - y2) || x1 == x2 || y1 == y2) legalMove = true;
        }
      }
    }
    //-----------------------------------------------end of Queen & Amazon-----------------------------------------------

    return legalMove;
  }
}
