import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'common_widgets.dart';

class StatsBar extends StatefulWidget {
  const StatsBar({super.key});

  @override
  State<StatsBar> createState() => _StatsBarState();
}

class _StatsBarState extends State<StatsBar> {
  bool _animate = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final pad = Responsive.contentPadding(context);

    final stats = [
      ('3', '+', 'Years Experience'),
      ('6', '+', 'Projects Shipped'),
      ('82', '', 'MCA Score'),
      ('3', '', 'Companies Worked'),
    ];

    return VisibilityDetector(
      key: const Key('stats-bar'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_animate) {
          setState(() => _animate = true);
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(pad, 0, pad, 80),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.flutterSky.withOpacity(0.08)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: isMobile
                ? GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    children: stats
                        .map((s) => _StatItem(
                              number: s.$1,
                              suffix: s.$2,
                              label: s.$3,
                              animate: _animate,
                            ))
                        .toList(),
                  )
                : Row(
                    children: stats.map((s) {
                      return Expanded(
                        child: _StatItem(
                          number: s.$1,
                          suffix: s.$2,
                          label: s.$3,
                          animate: _animate,
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatefulWidget {
  final String number, suffix, label;
  final bool animate;

  const _StatItem({
    required this.number,
    required this.suffix,
    required this.label,
    required this.animate,
  });

  @override
  State<_StatItem> createState() => _StatItemState();
}

class _StatItemState extends State<_StatItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          border: Border(
            top: BorderSide(color: AppTheme.flutterSky.withOpacity(0.08)),
            right: BorderSide(color: AppTheme.flutterSky.withOpacity(0.08)),
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AnimatedCounter(
                      end: int.parse(widget.number),
                      animate: widget.animate,
                    ),
                    if (widget.suffix.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: ShaderMask(
                          shaderCallback: (b) =>
                              AppTheme.skyGradient.createShader(b),
                          child: Text(
                            widget.suffix,
                            style: GoogleFonts.sora(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  widget.label.toUpperCase(),
                  style: GoogleFonts.sora(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // Bottom accent line
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                decoration: BoxDecoration(
                  gradient: _hovered ? AppTheme.primaryGradient : const LinearGradient(colors: [Colors.transparent, Colors.transparent]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
