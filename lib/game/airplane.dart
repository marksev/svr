class Airplane {
  Airplane({
    required this.x,
    required this.y,
    this.width = 48,
    this.height = 36,
  });

  final double x;
  double y;
  final double width;
  final double height;
  double velocityY = 0;

  void update(double dt, double gravity) {
    velocityY += gravity * dt;
    y += velocityY * dt;
  }

  void jump(double jumpForce) {
    velocityY = -jumpForce;
  }

  void reset(double startY) {
    y = startY;
    velocityY = 0;
  }
}
