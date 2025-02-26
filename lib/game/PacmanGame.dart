import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pacman/entities/Player.dart';

class PacmanGame extends FlameGame with KeyboardEvents, PanDetector {
  PacmanGame({
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