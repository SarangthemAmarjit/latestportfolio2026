import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/app_data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'common_widgets.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.contentPadding(context);
    final isMobile = Responsive.isMobile(context);
    final cols = isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 3);

    return VisibilityDetector(
      key: const Key('skills'),
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
            const SectionTag('Technical Stack'),
            const SizedBox(height: 16),
            SectionTitle(before: 'Skills & ', highlight: 'Technologies'),
            const SizedBox(height: 60),
            // Grid
            LayoutBuilder(builder: (ctx, constraints) {
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: AppData.skillGroups.asMap().entries.map((e) {
                  final width = cols == 1
                      ? constraints.maxWidth
                      : cols == 2
                          ? (constraints.maxWidth - 20) / 2
                          : (constraints.maxWidth - 40) / 3;
                  return SizedBox(
                    width: width,
                    child: _SkillCard(
                      group: e.value,
                      visible: _visible,
                      delay: Duration(milliseconds: e.key * 100),
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

class _SkillCard extends StatefulWidget {
  final SkillGroup group;
  final bool visible;
  final Duration delay;

  const _SkillCard({
    required this.group,
    required this.visible,
    required this.delay,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_SkillCard old) {
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
        child: GlowCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(widget.group.icon, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(
                    widget.group.category.toUpperCase(),
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      color: AppTheme.accentAmber,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.group.skills.map((s) => SkillTag(s)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
