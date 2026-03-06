import 'dart:math';

class Skyscraper {
  Skyscraper({
    required this.x,
    required this.width,
    required this.gapCenterY,
    required this.gapHeight,
  });

  double x;
  final double width;
  double gapCenterY;
  final double gapHeight;
  bool hasScored = false;

  void update(double dt, double speed) {
    x -= speed * dt;
  }

  void recycle({
    required double newX,
    required double screenHeight,
    required double minGapMargin,
    required Random random,
  }) {
    x = newX;
    hasScored = false;
    final minGapCenter = minGapMargin + gapHeight / 2;
    final maxGapCenter = screenHeight - minGapMargin - gapHeight / 2;
    gapCenterY = minGapCenter + random.nextDouble() * (maxGapCenter - minGapCenter);
  }

  double get topHeight => gapCenterY - gapHeight / 2;

  double bottomY(double screenHeight) => gapCenterY + gapHeight / 2;

  double bottomHeight(double screenHeight) => screenHeight - bottomY(screenHeight);
}
