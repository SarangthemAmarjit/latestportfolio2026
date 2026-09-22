import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/app_data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'common_widgets.dart';

class EducationSection extends StatefulWidget {
  const EducationSection({super.key});

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.contentPadding(context);
    final isMobile = Responsive.isMobile(context);
    final cols = isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 4);

    return VisibilityDetector(
      key: const Key('education'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: pad, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTag('Academic Background'),
            const SizedBox(height: 16),
            SectionTitle(before: 'My ', highlight: 'Education'),
            const SizedBox(height: 60),
            LayoutBuilder(builder: (ctx, constraints) {
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: AppData.educations.asMap().entries.map((e) {
                  final itemCols = cols;
                  final spacing = (itemCols - 1) * 20.0;
                  final w = (constraints.maxWidth - spacing) / itemCols;
                  return SizedBox(
                    width: w,
                    child: _EduCard(
                      edu: e.value,
                      visible: _visible,
                      delay: Duration(milliseconds: e.key * 120),
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _EduCard extends StatefulWidget {
  final Education edu;
  final bool visible;
  final Duration delay;

  const _EduCard({
    required this.edu,
    required this.visible,
    required this.delay,
  });

  @override
  State<_EduCard> createState() => _EduCardState();
}

class _EduCardState extends State<_EduCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_EduCard old) {
    super.didUpdateWidget(old);
    if (widget.visible && !old.visible) {
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: widget.edu.isHighlight
                    ? AppTheme.flutterSky.withOpacity(_hovered ? 0.5 : 0.35)
                    : AppTheme.flutterSky.withOpacity(_hovered ? 0.3 : 0.1),
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: AppTheme.flutterBlue.withOpacity(0.1),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      )
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.edu.isHighlight)
                      const Text('✦', style: TextStyle(color: AppTheme.flutterSky, fontSize: 14)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.edu.isHighlight
                            ? AppTheme.flutterSky.withOpacity(0.1)
                            : AppTheme.accentAmber.withOpacity(0.08),
                        border: Border.all(
                          color: widget.edu.isHighlight
                              ? AppTheme.flutterSky.withOpacity(0.35)
                              : AppTheme.accentAmber.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.edu.year,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          color: widget.edu.isHighlight
                              ? AppTheme.flutterSky
                              : AppTheme.accentAmber,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  widget.edu.institution,
                  style: GoogleFonts.sora(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.edu.degree,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    color: AppTheme.flutterSky,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Score: ',
                      style: GoogleFonts.sora(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                      ),
                    ),
                    Text(
                      widget.edu.score,
                      style: GoogleFonts.sora(
                        fontSize: 12,
                        color: widget.edu.isHighlight
                            ? AppTheme.flutterSky
                            : AppTheme.textMuted,
                        fontWeight: widget.edu.isHighlight ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                    if (widget.edu.isHighlight)
                      const Text(' ✦',
                          style: TextStyle(color: AppTheme.flutterSky, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
