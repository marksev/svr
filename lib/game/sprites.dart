import 'package:flutter/material.dart';

class AirplaneSprite extends StatelessWidget {
  const AirplaneSprite({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/airplane.png',
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const CustomPaint(painter: _AirplanePainter()),
    );
  }
}

class SkyscraperSprite extends StatelessWidget {
  const SkyscraperSprite({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/skyscraper.png',
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const CustomPaint(painter: _SkyscraperPainter()),
    );
  }
}

class _AirplanePainter extends CustomPainter {
  const _AirplanePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final body = Paint()..color = const Color(0xFFF34B31);
    final stripe = Paint()..color = const Color(0xFFFFC64A);
    final belly = Paint()..color = const Color(0xFFF0F4FF);
    final cockpit = Paint()..color = const Color(0xFF9ED3F7);
    final propeller = Paint()..color = const Color(0x88858B98);

    final bodyPath = Path()
      ..moveTo(w * 0.06, h * 0.52)
      ..lineTo(w * 0.68, h * 0.32)
      ..lineTo(w * 0.80, h * 0.40)
      ..lineTo(w * 0.92, h * 0.50)
      ..lineTo(w * 0.80, h * 0.60)
      ..lineTo(w * 0.68, h * 0.70)
      ..lineTo(w * 0.08, h * 0.58)
      ..close();
    canvas.drawPath(bodyPath, body);

    final stripePath = Path()
      ..moveTo(w * 0.12, h * 0.53)
      ..lineTo(w * 0.66, h * 0.38)
      ..lineTo(w * 0.74, h * 0.42)
      ..lineTo(w * 0.66, h * 0.51)
      ..lineTo(w * 0.20, h * 0.58)
      ..close();
    canvas.drawPath(stripePath, stripe);

    final bellyPath = Path()
      ..moveTo(w * 0.18, h * 0.60)
      ..lineTo(w * 0.68, h * 0.58)
      ..lineTo(w * 0.78, h * 0.63)
      ..lineTo(w * 0.64, h * 0.78)
      ..lineTo(w * 0.22, h * 0.76)
      ..close();
    canvas.drawPath(bellyPath, belly);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.61, h * 0.45),
        width: w * 0.22,
        height: h * 0.28,
      ),
      cockpit,
    );

    final wingPaint = Paint()..color = const Color(0xFFF8BA30);
    final wing = Path()
      ..moveTo(w * 0.40, h * 0.56)
      ..lineTo(w * 0.60, h * 0.68)
      ..lineTo(w * 0.48, h * 0.90)
      ..lineTo(w * 0.30, h * 0.72)
      ..close();
    canvas.drawPath(wing, wingPaint);

    final tailWing = Path()
      ..moveTo(w * 0.08, h * 0.53)
      ..lineTo(w * 0.23, h * 0.46)
      ..lineTo(w * 0.20, h * 0.64)
      ..lineTo(w * 0.05, h * 0.68)
      ..close();
    canvas.drawPath(tailWing, wingPaint);

    final tail = Path()
      ..moveTo(w * 0.11, h * 0.53)
      ..lineTo(w * 0.18, h * 0.22)
      ..lineTo(w * 0.28, h * 0.26)
      ..lineTo(w * 0.26, h * 0.56)
      ..close();
    canvas.drawPath(tail, body);

    canvas.drawCircle(
      Offset(w * 0.88, h * 0.50),
      h * 0.10,
      Paint()..color = const Color(0xFFDA2E22),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.94, h * 0.50),
        width: w * 0.03,
        height: h * 0.66,
      ),
      propeller,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.94, h * 0.50),
        width: w * 0.10,
        height: h * 0.08,
      ),
      propeller,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SkyscraperPainter extends CustomPainter {
  const _SkyscraperPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final body = Paint()..color = const Color(0xFFA4ECF0);
    final side = Paint()..color = const Color(0xFF3FBBDD);
    final roofA = Paint()..color = const Color(0xFF4A91D8);
    final roofB = Paint()..color = const Color(0xFF65DCEA);

    canvas.drawRect(Rect.fromLTWH(w * 0.20, h * 0.14, w * 0.60, h * 0.78), body);
    final sidePath = Path()
      ..moveTo(w * 0.20, h * 0.14)
      ..lineTo(w * 0.30, h * 0.12)
      ..lineTo(w * 0.30, h * 0.92)
      ..lineTo(w * 0.20, h * 0.92)
      ..close();
    canvas.drawPath(sidePath, side);

    final roof1 = Path()
      ..moveTo(w * 0.26, h * 0.10)
      ..lineTo(w * 0.74, h * 0.06)
      ..lineTo(w * 0.74, h * 0.14)
      ..lineTo(w * 0.22, h * 0.16)
      ..close();
    canvas.drawPath(roof1, roofA);

    final roof2 = Path()
      ..moveTo(w * 0.34, h * 0.04)
      ..lineTo(w * 0.66, h * 0.04)
      ..lineTo(w * 0.72, h * 0.10)
      ..lineTo(w * 0.28, h * 0.11)
      ..close();
    canvas.drawPath(roof2, roofB);

    canvas.drawRect(
      Rect.fromLTWH(w * 0.38, h * 0.01, w * 0.24, h * 0.03),
      Paint()..color = const Color(0xFFF8CC50),
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.49, 0, w * 0.02, h * 0.02),
      Paint()..color = const Color(0xFF2D6EAF),
    );

    final windowPaint = Paint()..color = const Color(0xFFB6ECFF);
    for (var row = 0; row < 9; row++) {
      for (var col = 0; col < 3; col++) {
        final wx = w * (0.32 + col * 0.15);
        final wy = h * (0.19 + row * 0.075);
        canvas.drawRect(Rect.fromLTWH(wx, wy, w * 0.10, h * 0.05), windowPaint);
      }
    }

    canvas.drawRect(
      Rect.fromLTWH(w * 0.18, h * 0.92, w * 0.64, h * 0.03),
      Paint()..color = const Color(0xFFD9E6EE),
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.14, h * 0.95, w * 0.72, h * 0.03),
      Paint()..color = const Color(0xFFECAA39),
    );

    final outline = Paint()
      ..color = const Color(0xFF16528C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(Rect.fromLTWH(w * 0.20, h * 0.14, w * 0.60, h * 0.78), outline);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
