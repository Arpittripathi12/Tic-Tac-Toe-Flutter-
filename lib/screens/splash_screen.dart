import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/screens/TicTacToeGame.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    super.initState();

    Future.delayed(
      Duration(seconds: 4),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TicTacToeGame()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the World of \nTic Tac Toe ', textAlign: TextAlign.center,style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            Image.asset('assets/gifs/tic-tac-toe.gif'),
          ],
        ),
      ) , 
    );
  }
}