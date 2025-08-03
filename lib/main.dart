import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tic_tac_toe_game/provider/game_provider.dart';
import 'package:tic_tac_toe_game/screens/splash_screen.dart';
import 'screens/TicTacToeGame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TicTacToeProvider(),
      child: MaterialApp(
        title: 'Tic Tac Toe',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
       
      ),
    );
  }
}
