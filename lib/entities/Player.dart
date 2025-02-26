import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/services.dart';
import 'package:pacman/entities/Entity.dart';

class Player extends Entity with KeyboardHandler {
  Player({required super.position, required super.size});

  @override
  Future<dynamic> onLoad() async {
    super.onLoad();
    animation = await getAnimationForDirection(direction, 0.2);
  }

  @override
  Future<void> onDirectionChanged(Direction newDirection) async {
    super.onDirectionChanged(newDirection);
    animation = await getAnimationForDirection(direction, 0.2);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    if (event is KeyUpEvent) return false;

    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      requestedDirection =
          (direction == Direction.right) ? Direction.none : Direction.left;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      requestedDirection =
          (direction == Direction.left) ? Direction.none : Direction.right;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      requestedDirection =
          (direction == Direction.down) ? Direction.none : Direction.up;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      requestedDirection =
          (direction == Direction.up) ? Direction.none : Direction.down;
    }

    return false;
  }

  void onPanUpdate(DragUpdateInfo info) {
    Vector2 velocity = info.delta.global;

    if (velocity.isZero() || velocity.length < 10) return;

    bool isX = velocity.x.abs() > velocity.y.abs();

    if (isX) {
      requestedDirection = (velocity.x < 0) ? Direction.left : Direction.right;
    } else {
      requestedDirection = (velocity.y < 0) ? Direction.up : Direction.down;
    }
  }

  Future<SpriteAnimation> getAnimationForDirection(
    Direction direction,
    double animationDelay,
  ) async {
    String name = direction != Direction.none ? direction.name : 'stop';
    return SpriteAnimation([
      SpriteAnimationFrame(
        await Sprite.load('characters/p/coop/coplayer_${name}1.png'),
        animationDelay,
      ),
      SpriteAnimationFrame(
        await Sprite.load('characters/p/coop/coplayer_${name}2.png'),
        animationDelay,
      ),
    ]);
  }
}
