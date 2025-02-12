import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(HeartbeatApp());
}

class HeartbeatApp extends StatefulWidget {
  @override
  _HeartbeatAppState createState() => _HeartbeatAppState();
}

class _HeartbeatAppState extends State<HeartbeatApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Heartbeat animation setup
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.pink[50],
        body: Stack(
          children: [
            Center(
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'assets/heart.png', // Main pulsing heart image
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            ConfettiEffect(), // confetti effect
          ],
        ),
      ),
    );
  }
}

// confetti effect
class ConfettiEffect extends StatefulWidget {
  @override
  _ConfettiEffectState createState() => _ConfettiEffectState();
}

class _ConfettiEffectState extends State<ConfettiEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation =
        Tween<double>(begin: 0.3, end: 1.0).animate(_fadeController);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Opacity(
          opacity: _fadeAnimation.value,
          child: Image.asset(
            'assets/confetti.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
