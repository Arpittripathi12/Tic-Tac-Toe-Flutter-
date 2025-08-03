import 'package:flutter/material.dart';

class TicTacToeProvider extends ChangeNotifier {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';
  List<int> winningIndexes = [];
  int player1Wins = 0;
  int player2Wins = 0;


// Handles on Tap on any card
  void handleTap(int index) {
    if (board[index] == '' && winner == '') {
      board[index] = currentPlayer;
      _checkWinner();
      if (winner == '') {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
      notifyListeners();
    }
  }

// Checking if there any winner exist up to this moment
  void _checkWinner() {
    List<List<int>> winningCombinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], 
      [0, 3, 6], [1, 4, 7], [2, 5, 8], 
      [0, 4, 8], [2, 4, 6],            
    ];
    for (var combo in winningCombinations) {
      String a = board[combo[0]];
      String b = board[combo[1]];
      String c = board[combo[2]];

// checking and storing winner
      if (a != '' && a == b && b == c) {
        winner = a;
        winningIndexes = combo;

        if (winner == 'X') player1Wins++;
        else if (winner == 'O') player2Wins++;
        return;
      }
    }
// if winner is empty and we have fill all the places in the board
    if (!board.contains('') && winner == '') {
      winner = 'Draw';
    }
  }
// reset game
  void resetGame() {
    board = List.filled(9, '');
    currentPlayer = 'X';
    winner = '';
    winningIndexes = [];
    notifyListeners();
  }
// reset scores of both the players
  void resetScores() {
    player1Wins = 0;
    player2Wins = 0;
    resetGame();
  }
// if a player wins then change the color of winning indices 
  Color getCellColor(int index) {
    if (winningIndexes.contains(index)) {
      return Colors.greenAccent;
    }
    return Colors.blue;
  }
}
