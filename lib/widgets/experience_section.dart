import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/app_data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'common_widgets.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.contentPadding(context);

    return VisibilityDetector(
      key: const Key('experience'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        color: AppTheme.dark2.withOpacity(0.4),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pad, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTag('Work History'),
              const SizedBox(height: 16),
              SectionTitle(before: 'Professional ', highlight: 'Experience'),
              const SizedBox(height: 60),
              _Timeline(visible: _visible),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Timeline — Row-based, no IntrinsicHeight ─────────────────────────────────
// Uses a Row with a fixed left column for dots+line and an Expanded right column.
// The vertical line is drawn via CustomPaint on the left SizedBox.
class _Timeline extends StatelessWidget {
  final bool visible;
  const _Timeline({required this.visible});

  @override
  Widget build(BuildContext context) {
    final items = AppData.experiences.asMap().entries.map((e) {
      return _TimelineItem(
        experience: e.value,
        visible: visible,
        delay: Duration(milliseconds: e.key * 150),
      );
    }).toList();

    // We wrap everything in a LayoutBuilder to give the CustomPaint a real height
    return LayoutBuilder(builder: (ctx, constraints) {
      return Stack(
        children: [
          // Vertical gradient line at x=7 (centre of 14-wide left gutter)
          Positioned(
            left: 7,
            top: 0,
            bottom: 0,
            width: 1,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppTheme.flutterBlue,
                    AppTheme.flutterDart,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Items — natural height, no IntrinsicHeight
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
        ],
      );
    });
  }
}

// ─── Timeline Item ────────────────────────────────────────────────────────────
class _TimelineItem extends StatefulWidget {
  final Experience experience;
  final bool visible;
  final Duration delay;

  const _TimelineItem({
    required this.experience,
    required this.visible,
    required this.delay,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(-0.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_TimelineItem old) {
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

  Color get _dotColor {
    if (widget.experience.isCurrent) return AppTheme.accentAmber;
    if (widget.experience.company == 'Globizs') return AppTheme.flutterDart;
    return AppTheme.flutterBlue;
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Padding(
          // Left padding = 14 (dot gutter) + 24 (gap) = 38
          padding: const EdgeInsets.only(left: 38, bottom: 56),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Dot — sits over the line at left: -31
              Positioned(
                left: -31,
                top: 4,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: _dotColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.dark, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: _dotColor.withOpacity(0.55),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              // Content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Period + CURRENT badge
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    runSpacing: 6,
                    children: [
                      Text(
                        widget.experience.period,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          color: AppTheme.accentAmber,
                          letterSpacing: 0.8,
                        ),
                      ),
                      if (widget.experience.isCurrent)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.flutterDart.withOpacity(0.15),
                            border: Border.all(
                              color: AppTheme.flutterDart.withOpacity(0.4),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'CURRENT',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 9,
                              color: AppTheme.flutterDart,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.experience.company,
                    style: GoogleFonts.sora(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.experience.role,
                    style: GoogleFonts.sora(
                      fontSize: 13,
                      color: AppTheme.flutterSky,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.experience.description,
                    style: GoogleFonts.sora(
                      fontSize: 14,
                      color: AppTheme.textMuted,
                      height: 1.7,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
