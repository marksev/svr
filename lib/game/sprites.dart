import 'package:flutter/material.dart';

class AirplaneSprite extends StatelessWidget {
  const AirplaneSprite({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/airplane.png',
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const _AirplaneFallback(),
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
      errorBuilder: (_, __, ___) => const _SkyscraperFallback(),
    );
  }
}

class _AirplaneFallback extends StatelessWidget {
  const _AirplaneFallback();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.airplanemode_active, color: Colors.red);
  }
}

class _SkyscraperFallback extends StatelessWidget {
  const _SkyscraperFallback();

  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFFA4ECF0));
  }
}
