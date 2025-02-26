import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'entities/Player.dart';

void main() {
  Flame.images.prefix = kIsWeb ? 'images/' : 'assets/images/';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MyGame(
        world: MyWorld()
      )
    );
  }
}

class MyGame extends FlameGame with KeyboardEvents, PanDetector {
  MyGame({
    super.world,
    super.camera,
    super.children,
  });

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;
    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    world.children.whereType<KeyboardHandler>().forEach((element) {
      element.onKeyEvent(event, keysPressed);
    },);

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    world.children.whereType<Player>().forEach((element) {
      element.onPanUpdate(info);
    },);
    super.onPanUpdate(info);
  }

}

class MyWorld extends World with HasGameRef {

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
