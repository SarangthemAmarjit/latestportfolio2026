import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

// ─── Section Tag ────────────────────────────────────────────────────────────
class SectionTag extends StatelessWidget {
  final String label;
  const SectionTag(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '// ',
          style: GoogleFonts.jetBrainsMono(
            color: AppTheme.accentAmber,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label.toUpperCase(),
          style: GoogleFonts.jetBrainsMono(
            color: AppTheme.flutterSky,
            fontSize: 12,
            letterSpacing: 1.8,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─── Section Title ───────────────────────────────────────────────────────────
class SectionTitle extends StatelessWidget {
  final String before;
  final String highlight;
  final double fontSize;

  const SectionTitle({
    super.key,
    required this.before,
    required this.highlight,
    this.fontSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: before,
            style: GoogleFonts.sora(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              color: AppTheme.white,
              letterSpacing: -1.2,
              height: 1.1,
            ),
          ),
          TextSpan(
            text: highlight,
            style: GoogleFonts.sora(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              color: AppTheme.flutterSky,
              letterSpacing: -1.2,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Gradient Button ─────────────────────────────────────────────────────────
class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool outline;
  final String? icon;

  const GradientButton({
    super.key,
    required this.label,
    this.onTap,
    this.outline = false,
    this.icon,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          decoration: widget.outline
              ? BoxDecoration(
                  border: Border.all(
                    color: _hovered
                        ? AppTheme.flutterSky
                        : AppTheme.flutterSky.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(10),
                )
              : BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: AppTheme.flutterBlue.withOpacity(0.5),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          )
                        ]
                      : [],
                ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Text(widget.icon!, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: GoogleFonts.sora(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: widget.outline
                      ? (_hovered ? AppTheme.flutterSky : AppTheme.textPrimary)
                      : AppTheme.white,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Glowing Card ─────────────────────────────────────────────────────────────
class GlowCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool topAccent;

  const GlowCard({
    super.key,
    required this.child,
    this.padding,
    this.topAccent = true,
  });

  @override
  State<GlowCard> createState() => _GlowCardState();
}

class _GlowCardState extends State<GlowCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
        padding: widget.padding ?? const EdgeInsets.all(28),
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
                    color: AppTheme.flutterBlue.withOpacity(0.12),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  )
                ]
              : [],
        ),
        child: Column(
          children: [
            if (widget.topAccent)
              Container(
                height: 2,
                decoration: const BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
            SizedBox(
              height: 5,
            ),
            widget.child,
          ],
        ),
      ),
    );
  }
}

// ─── Skill Tag ────────────────────────────────────────────────────────────────
class SkillTag extends StatefulWidget {
  final String label;
  const SkillTag(this.label, {super.key});

  @override
  State<SkillTag> createState() => _SkillTagState();
}

class _SkillTagState extends State<SkillTag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: _hovered
              ? AppTheme.flutterSky.withOpacity(0.15)
              : AppTheme.flutterBlue.withOpacity(0.08),
          border: Border.all(
            color: _hovered
                ? AppTheme.flutterSky.withOpacity(0.5)
                : AppTheme.flutterSky.withOpacity(0.15),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            color: _hovered ? AppTheme.flutterSky : AppTheme.textPrimary,
          ),
        ),
      ),
    );
  }
}

// ─── Nav Link ─────────────────────────────────────────────────────────────────
class NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const NavLink({super.key, required this.label, required this.onTap});

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label.toUpperCase(),
              style: GoogleFonts.sora(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _hovered ? AppTheme.flutterSky : AppTheme.textMuted,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 1,
              width: _hovered ? 30 : 0,
              color: AppTheme.flutterSky,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Animated Counter ─────────────────────────────────────────────────────────
class AnimatedCounter extends StatefulWidget {
  final int end;
  final String suffix;
  final bool animate;

  const AnimatedCounter({
    super.key,
    required this.end,
    this.suffix = '',
    this.animate = false,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    if (widget.animate) _ctrl.forward();
  }

  @override
  void didUpdateWidget(AnimatedCounter old) {
    super.didUpdateWidget(old);
    if (widget.animate && !old.animate) _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final val = (_anim.value * widget.end).floor();
        return ShaderMask(
          shaderCallback: (bounds) => AppTheme.skyGradient.createShader(bounds),
          child: Text(
            '$val${widget.suffix}',
            style: GoogleFonts.sora(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: AppTheme.white,
              height: 1,
            ),
          ),
        );
      },
    );
  }
}

// ─── Tech Badge ───────────────────────────────────────────────────────────────
class TechBadge extends StatelessWidget {
  final String label;
  const TechBadge(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: AppTheme.flutterSky.withOpacity(0.06),
        border: Border.all(color: AppTheme.flutterSky.withOpacity(0.15)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 10,
          color: AppTheme.textMuted,
        ),
      ),
    );
  }
}
