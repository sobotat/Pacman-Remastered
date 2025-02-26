import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:pacman/entities/Player.dart';

class GameWorld extends World with HasGameRef {

  @override
  Future<void> onLoad() async {
    await Flame.images.loadAllImages();

    add(Player(
      position: Vector2(0, 0),
      size: Vector2(30, 30),
    ));
    add(FpsTextComponent(
      position: Vector2(game.size.x - 60, 0),
      scale: Vector2.all(.6)
    ));
  }
}
