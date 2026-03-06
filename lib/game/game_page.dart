import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'game_controller.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const _frameDuration = Duration(milliseconds: 16);

  final GameController _controller = GameController();
  final AudioPlayer _jumpPlayer = AudioPlayer();
  final AudioPlayer _crashPlayer = AudioPlayer();

  Timer? _loop;
  DateTime? _lastTickTime;
  bool _playedCrash = false;

  @override
  void initState() {
    super.initState();
    _startLoop();
  }

  void _startLoop() {
    _loop?.cancel();
    _lastTickTime = DateTime.now();

    _loop = Timer.periodic(_frameDuration, (_) {
      if (!mounted) {
        return;
      }

      final now = DateTime.now();
      final dt = now.difference(_lastTickTime!).inMilliseconds / 1000;
      _lastTickTime = now;

      final screenSize = MediaQuery.sizeOf(context);
      final wasGameOver = _controller.gameOver;

      setState(() {
        _controller.update(dt, screenSize.width, screenSize.height);
      });

      if (!wasGameOver && _controller.gameOver) {
        _playCrashSound();
      }
    });
  }

  Future<void> _playJumpSound() async {
    await _jumpPlayer.stop();
    await _jumpPlayer.play(AssetSource('sounds/jump.wav'));
  }

  Future<void> _playCrashSound() async {
    if (_playedCrash) {
      return;
    }

    _playedCrash = true;
    await _crashPlayer.stop();
    await _crashPlayer.play(AssetSource('sounds/crash.wav'));
  }

  void _onTap() {
    if (_controller.gameOver) {
      return;
    }

    _controller.onTap();
    _playJumpSound();
  }

  void _restart() {
    final screenHeight = MediaQuery.sizeOf(context).height;
    setState(() {
      _playedCrash = false;
      _controller.restart(screenHeight);
    });
  }

  @override
  void dispose() {
    _loop?.cancel();
    _jumpPlayer.dispose();
    _crashPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final playableHeight = size.height - _controller.groundHeight;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Stack(
          children: [
            Container(color: const Color(0xFF6EC6FF)),
            for (final skyscraper in _controller.skyscrapers) ...[
              Positioned(
                left: skyscraper.x,
                top: 0,
                width: skyscraper.width,
                height: skyscraper.topHeight,
                child: Image.asset(
                  'assets/images/skyscraper.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: const Color(0xFFA4ECF0)),
                ),
              ),
              Positioned(
                left: skyscraper.x,
                top: skyscraper.bottomY(playableHeight),
                width: skyscraper.width,
                height: skyscraper.bottomHeight(playableHeight),
                child: Image.asset(
                  'assets/images/skyscraper.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: const Color(0xFFA4ECF0)),
                ),
              ),
            ],
            Positioned(
              left: _controller.airplane.x,
              top: _controller.airplane.y,
              width: _controller.airplane.width,
              height: _controller.airplane.height,
              child: Image.asset(
                'assets/images/airplane.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.airplanemode_active, color: Colors.red),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 50,
              child: Text(
                'Score: ${_controller.score}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(blurRadius: 8, color: Colors.black45, offset: Offset(1, 2)),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: _controller.groundHeight,
              child: Container(color: const Color(0xFF8D6E63)),
            ),
            if (_controller.gameOver)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Game Over',
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _restart,
                      child: const Text('Restart'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
