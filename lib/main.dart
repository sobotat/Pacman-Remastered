import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pacman/game/PacmanGame.dart';
import 'package:pacman/game/worlds/GameWorld.dart';

void main() {
  Flame.images.prefix = kIsWeb ? 'images/' : 'assets/images/';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: PacmanGame(
        world: GameWorld()
      )
    );
  }
}
