import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ParticlesBackground extends StatefulWidget {
  const ParticlesBackground({super.key});

  @override
  State<ParticlesBackground> createState() => _ParticlesBackgroundState();
}

class _ParticlesBackgroundState extends State<ParticlesBackground>
    with TickerProviderStateMixin {
  final List<_Particle> _particles = [];
  late AnimationController _ctrl;
  final Random _rand = Random();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 20; i++) {
      _particles.add(_Particle(
        x: _rand.nextDouble(),
        y: _rand.nextDouble(),
        size: _rand.nextDouble() * 3 + 1.5,
        speed: _rand.nextDouble() * 0.0002 + 0.0001,
        color: [
          AppTheme.flutterBlue,
          AppTheme.flutterSky,
          AppTheme.flutterDart,
          AppTheme.accentAmber,
        ][_rand.nextInt(4)].withOpacity(0.4),
        phase: _rand.nextDouble() * 2 * pi,
      ));
    }

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final t = _ctrl.value;
        return CustomPaint(
          painter: _ParticlePainter(particles: _particles, t: t),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _Particle {
  final double x, size, speed, phase;
  double y;
  final Color color;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.color,
    required this.phase,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double t;

  _ParticlePainter({required this.particles, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final y = (p.y - t * 0.15 * (p.speed / 0.0002)) % 1.0;
      final opacity = sin(t * 2 * pi + p.phase).abs() * 0.5 + 0.1;
      final paint = Paint()
        ..color = p.color.withOpacity(opacity.clamp(0.0, 0.6))
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(p.x * size.width, y * size.height),
        p.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.t != t;
}

// ─── Background Mesh Gradient ─────────────────────────────────────────────────
class BackgroundMesh extends StatelessWidget {
  const BackgroundMesh({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.8, -0.6),
          radius: 1.2,
          colors: [
            Color(0x1E027DFD),
            Colors.transparent,
          ],
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.8, 0.6),
            radius: 1.0,
            colors: [
              Color(0x1800B4AB),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
