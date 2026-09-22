import 'package:amarjit_portfolio/controller/screencontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_theme.dart';

class FlutterFAB extends StatefulWidget {
  const FlutterFAB({super.key});

  @override
  State<FlutterFAB> createState() => _FlutterFABState();
}

class _FlutterFABState extends State<FlutterFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _bob;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _bob = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenController sccon = Get.put(ScreenController());
    return AnimatedBuilder(
      animation: _bob,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _bob.value),
        child: child,
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () {
            sccon.scrollTo('hero');
          }, // Placeholder for FAB action
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.flutterBlue, AppTheme.flutterDart],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.flutterBlue.withOpacity(_hovered ? 0.6 : 0.4),
                  blurRadius: _hovered ? 24 : 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: _FlutterLogo(),
            ),
          ),
        ),
      ),
    );
  }
}

class _FlutterLogo extends StatelessWidget {
  const _FlutterLogo();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(26, 26),
      painter: _FlutterLogoPainter(),
    );
  }
}

class _FlutterLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Simple Flutter-inspired chevrons
    final path1 = Path()
      ..moveTo(size.width * 0.5, size.height * 0.2) // Arrow tip (top center)
      ..lineTo(size.width * 0.75, size.height * 0.6) // Right slope
      ..lineTo(size.width * 0.6, size.height * 0.6) // Right inner
      ..lineTo(size.width * 0.6, size.height) // Right base
      ..lineTo(size.width * 0.4, size.height) // Left base
      ..lineTo(size.width * 0.4, size.height * 0.6) // Left inner
      ..lineTo(size.width * 0.25, size.height * 0.6) // Left slope
      ..close();

    canvas.drawPath(path1, paint);

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final path2 = Path()
      ..moveTo(size.width * 0.5, size.height * 0.2) // Arrow tip (top center)
      ..lineTo(size.width * 0.75, size.height * 0.6) // Right slope
      ..lineTo(size.width * 0.6, size.height * 0.6) // Right inner
      ..lineTo(size.width * 0.6, size.height) // Right base
      ..lineTo(size.width * 0.4, size.height) // Left base
      ..lineTo(size.width * 0.4, size.height * 0.6) // Left inner
      ..lineTo(size.width * 0.25, size.height * 0.6) // Left slope
      ..close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(_) => false;
}
