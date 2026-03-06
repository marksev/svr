import 'dart:math';

import 'airplane.dart';
import 'skyscraper.dart';

class GameController {
  GameController()
      : airplane = Airplane(x: 96, y: 300),
        skyscrapers = [] {
    _initializeSkyscrapers();
  }

  final Random _random = Random();

  final Airplane airplane;
  final List<Skyscraper> skyscrapers;

  int score = 0;
  bool gameOver = false;

  double gravity = 900;
  double jumpForce = 360;
  double scrollSpeed = 140;
  double groundHeight = 80;
  double skyscraperWidth = 72;
  double gapHeight = 170;
  double skyscraperSpacing = 220;

  void _initializeSkyscrapers() {
    skyscrapers.clear();
    for (var i = 0; i < 3; i++) {
      skyscrapers.add(
        Skyscraper(
          x: 420 + i * skyscraperSpacing,
          width: skyscraperWidth,
          gapCenterY: 260,
          gapHeight: gapHeight,
        ),
      );
    }
  }

  void restart(double screenHeight) {
    score = 0;
    gameOver = false;
    airplane.reset(screenHeight / 2 - airplane.height / 2);

    for (var i = 0; i < skyscrapers.length; i++) {
      skyscrapers[i].recycle(
        newX: 420 + i * skyscraperSpacing,
        screenHeight: screenHeight - groundHeight,
        minGapMargin: 60,
        random: _random,
      );
    }
  }

  void onTap() {
    if (!gameOver) {
      airplane.jump(jumpForce);
    }
  }

  void update(double dt, double screenWidth, double screenHeight) {
    if (gameOver) {
      return;
    }

    final playableHeight = screenHeight - groundHeight;

    airplane.update(dt, gravity);

    for (final skyscraper in skyscrapers) {
      skyscraper.update(dt, scrollSpeed);

      if (!skyscraper.hasScored && skyscraper.x + skyscraper.width < airplane.x) {
        skyscraper.hasScored = true;
        score += 1;
      }
    }

    final rightMostX = skyscrapers.map((s) => s.x).reduce(max);
    for (final skyscraper in skyscrapers) {
      if (skyscraper.x + skyscraper.width < 0) {
        skyscraper.recycle(
          newX: rightMostX + skyscraperSpacing,
          screenHeight: playableHeight,
          minGapMargin: 60,
          random: _random,
        );
      }
    }

    if (_isOutOfBounds(playableHeight) || _hasCollision(playableHeight)) {
      gameOver = true;
    }

    if (airplane.y < 0) {
      airplane.y = 0;
      airplane.velocityY = 0;
    }
  }

  bool _isOutOfBounds(double playableHeight) {
    return airplane.y + airplane.height >= playableHeight;
  }

  bool _hasCollision(double playableHeight) {
    final planeLeft = airplane.x;
    final planeRight = airplane.x + airplane.width;
    final planeTop = airplane.y;
    final planeBottom = airplane.y + airplane.height;

    for (final skyscraper in skyscrapers) {
      final left = skyscraper.x;
      final right = skyscraper.x + skyscraper.width;

      final horizontalOverlap = planeRight > left && planeLeft < right;
      if (!horizontalOverlap) {
        continue;
      }

      final topCollision = planeTop < skyscraper.topHeight;
      final bottomCollision = planeBottom > skyscraper.bottomY(playableHeight);

      if (topCollision || bottomCollision) {
        return true;
      }
    }

    return false;
  }
}
