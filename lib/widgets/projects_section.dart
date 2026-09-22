import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/app_data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'common_widgets.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.contentPadding(context);
    final isMobile = Responsive.isMobile(context);
    final cols = isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 2);

    return VisibilityDetector(
      key: const Key('projects'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
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
              const SectionTag('Work'),
              const SizedBox(height: 16),
              SectionTitle(before: 'Featured ', highlight: 'Projects'),
              const SizedBox(height: 60),
              LayoutBuilder(builder: (ctx, constraints) {
                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: AppData.projects.asMap().entries.map((e) {
                    final w = cols == 1
                        ? constraints.maxWidth
                        : (constraints.maxWidth - 24) / 2;
                    return SizedBox(
                      width: w,
                      child: _ProjectCard(
                        project: e.value,
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
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final bool visible;
  final Duration delay;

  const _ProjectCard({
    required this.project,
    required this.visible,
    required this.delay,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_ProjectCard old) {
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

  Future<void> _launch() async {
    if (widget.project.url == null) return;
    final uri = Uri.parse(widget.project.url!);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: MouseRegion(
          cursor: widget.project.url != null
              ? SystemMouseCursors.click
              : MouseCursor.defer,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.project.url != null ? _launch : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _hovered
                      ? AppTheme.flutterSky.withOpacity(0.35)
                      : AppTheme.flutterSky.withOpacity(0.12),
                ),
                boxShadow: _hovered
                    ? [
                        BoxShadow(
                          color: AppTheme.flutterBlue.withOpacity(0.15),
                          blurRadius: 48,
                          offset: const Offset(0, 20),
                        )
                      ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.flutterBlue.withOpacity(0.12),
                      border: Border.all(color: AppTheme.flutterSky.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        widget.project.emoji,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.project.title,
                    style: GoogleFonts.sora(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.project.description,
                    style: GoogleFonts.sora(
                      fontSize: 13,
                      color: AppTheme.textMuted,
                      height: 1.7,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.project.tags.map((t) => TechBadge(t)).toList(),
                  ),
                  if (widget.project.url != null) ...[
                    const SizedBox(height: 20),
                    AnimatedSlide(
                      offset: _hovered ? const Offset(0.04, 0) : Offset.zero,
                      duration: const Duration(milliseconds: 200),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Project',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 11,
                              color: AppTheme.flutterSky,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_forward,
                            size: 12,
                            color: AppTheme.flutterSky,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
