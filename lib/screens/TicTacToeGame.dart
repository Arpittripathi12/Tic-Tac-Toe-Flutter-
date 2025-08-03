import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game/provider/game_provider.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController=ConfettiController(duration: Duration(seconds: 2));
  }
   
   @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq=MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children:[
                
          Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 225, 33, 186), Color.fromARGB(255, 18, 179, 243)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Consumer<TicTacToeProvider>(
              builder: (context, game,_) {
                 if (game.winner.isNotEmpty && game.winner != 'Draw') {
        _confettiController.play();
            }
                return Column(
                  
                  
                  children: [
                    SizedBox(height: mq.height*0.025),
                
                  // PLayers ScoreCard 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildScoreCard('Player 1 (X)', game.player1Wins, Colors.black),
                        _buildScoreCard('Player 2 (O)', game.player2Wins, Colors.black),
                      ],
                    ),
                     SizedBox(height: mq.height*0.05),
                
                    // Current status text of Player
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 400),
                      style: TextStyle(
                        fontSize: mq.height*0.035,
                        fontWeight: FontWeight.bold,
                        color: game.winner.isNotEmpty
                            ? (game.winner == 'Draw'
                                ? Colors.amber
                                : Colors.greenAccent)
                            : Colors.white,
                      ),
                      child: Text(
                        game.winner.isNotEmpty
                            ? (game.winner == 'Draw'
                                ? "It's a Draw!"
                                : 'Player ${game.winner} Wins!')
                            : 'Current Player: ${game.currentPlayer}',
                      ),
                    ),
                     SizedBox(height:mq.height*0.02),
                
                    // Tic-Tac-Toe Grid UI
                    Expanded(
                      child: Center(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: 9,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => game.handleTap(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin:  EdgeInsets.all(mq.height*0.006),
                                decoration: BoxDecoration(
                                  color: game.getCellColor(index),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    game.board[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: mq.height*0.06,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                
                  
                    Padding(
                      padding:  EdgeInsets.only(bottom: mq.height*0.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => game.resetGame(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding:  EdgeInsets.symmetric(horizontal: mq.width*0.06, vertical: mq.height*0.015),
                            ),
                            child:  Text(
                              'Restart Game',
                              style: TextStyle(fontSize: mq.height*0.018, fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => game.resetScores(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding:  EdgeInsets.symmetric(horizontal: mq.width*0.06, vertical: mq.height*0.015),
                            ),
                            child:  Text(
                              'Reset Scores',
                              style: TextStyle(fontSize:  mq.height*0.018 , fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
          }
            ),
          ),
        ),

         ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          emissionFrequency: 0.1,
          numberOfParticles: 60,
          gravity: 0.3,
        ),
          
          
          
      ]),
    );
  }


  Widget _buildScoreCard(String title, int score, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            '$score',
            style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          
        ],
      ),
    ); 
  }
}
