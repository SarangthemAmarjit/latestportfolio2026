import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'common_widgets.dart';

// ─── About Me Data ─────────────────────────────────────────────────────────
const String _aboutHeadline =
    "I'm a Flutter Developer & Software Engineer who loves\nbuilding elegant, cross-platform applications.";

const String _aboutDetail =
    "I am a passionate Software Developer with expertise in Flutter and Dart, "
    "dedicated to crafting efficient and user-friendly mobile and web applications. "
    "With hands-on experience across the full development lifecycle — from ideation "
    "to deployment — I thrive on solving complex problems with clean, scalable code.\n\n"
    "I have worked on diverse projects ranging from government department websites and "
    "construction portfolios to AI-powered deep learning classifiers and cultural "
    "preservation tools. I am a fast learner who quickly adapts to new technologies, "
    "and I continuously strive to enhance my knowledge to deliver high-quality results "
    "that add real value to every project I take on.";

const List<String> _tools = [
  'Flutter',
  'Dart',
  'Python',
  'Firebase',
  'Git',
  'Android',
  'Web',
  'REST API',
];

const List<Map<String, String>> _personalInfo = [
  {'label': 'Name', 'value': 'Sarangthem Amarjit Meetei'},
  {'label': 'Age', 'value': '27'},
  {'label': 'DOB', 'value': '01 / 01 / 1997'},
  {'label': 'Email', 'value': 'sarangthemamarjit123@gmail.com'},
  {'label': 'From', 'value': 'Langthabal Lep Makha Leikai, Imphal'},
  {'label': 'Languages', 'value': 'Manipuri, English'},
];

const List<Map<String, String>> _socialLinks = [
  {
    'label': 'GitHub',
    'icon': '⌥',
    'url': 'https://github.com/SarangthemAmarjit'
  },
  {
    'label': 'LinkedIn',
    'icon': 'in',
    'url': 'https://www.linkedin.com/in/sarang-amar'
  },
];

// ─── About Section ──────────────────────────────────────────────────────────
class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  late AnimationController _ctrl;
  late Animation<Offset> _leftSlide;
  late Animation<Offset> _rightSlide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _leftSlide = Tween<Offset>(
      begin: const Offset(-0.15, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    _rightSlide = Tween<Offset>(
      begin: const Offset(0.15, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _triggerAnimation() {
    if (!_visible) {
      setState(() => _visible = true);
      _ctrl.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final pad = Responsive.contentPadding(context);

    return VisibilityDetector(
      key: const Key('about-me'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) _triggerAnimation();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: pad, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: _fade,
              child: const SectionTag('About Me'),
            ),
            const SizedBox(height: 16),
            FadeTransition(
              opacity: _fade,
              child: SectionTitle(before: 'Get To ', highlight: 'Know Me :)'),
            ),
            const SizedBox(height: 70),
            isMobile
                ? _MobileLayout(
                    leftSlide: _leftSlide,
                    rightSlide: _rightSlide,
                    fade: _fade,
                  )
                : _DesktopLayout(
                    leftSlide: _leftSlide,
                    rightSlide: _rightSlide,
                    fade: _fade,
                  ),
          ],
        ),
      ),
    );
  }
}

// ─── Desktop Layout ──────────────────────────────────────────────────────────
class _DesktopLayout extends StatelessWidget {
  final Animation<Offset> leftSlide, rightSlide;
  final Animation<double> fade;

  const _DesktopLayout({
    required this.leftSlide,
    required this.rightSlide,
    required this.fade,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT — Photo
        Expanded(
          child: SlideTransition(
            position: leftSlide,
            child: FadeTransition(
              opacity: fade,
              child: const _PhotoPanel(),
            ),
          ),
        ),
        const SizedBox(width: 64),
        // RIGHT — Content
        Expanded(
          flex: 2,
          child: SlideTransition(
            position: rightSlide,
            child: FadeTransition(
              opacity: fade,
              child: const _ContentPanel(),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Mobile Layout ────────────────────────────────────────────────────────────
class _MobileLayout extends StatelessWidget {
  final Animation<Offset> leftSlide, rightSlide;
  final Animation<double> fade;

  const _MobileLayout({
    required this.leftSlide,
    required this.rightSlide,
    required this.fade,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeTransition(
          opacity: fade,
          child: SlideTransition(
            position: leftSlide,
            child: const _PhotoPanel(),
          ),
        ),
        const SizedBox(height: 48),
        FadeTransition(
          opacity: fade,
          child: SlideTransition(
            position: rightSlide,
            child: const _ContentPanel(),
          ),
        ),
      ],
    );
  }
}

// ─── Photo Panel ──────────────────────────────────────────────────────────────
class _PhotoPanel extends StatefulWidget {
  const _PhotoPanel();

  @override
  State<_PhotoPanel> createState() => _PhotoPanelState();
}

class _PhotoPanelState extends State<_PhotoPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowCtrl;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTag('Who am I?'),
        const SizedBox(height: 32),
        AnimatedBuilder(
          animation: _glow,
          builder: (_, child) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.flutterBlue.withOpacity(0.3 * _glow.value),
                  blurRadius: 40 * _glow.value,
                  spreadRadius: 4,
                ),
                BoxShadow(
                  color: AppTheme.flutterDart.withOpacity(0.15 * _glow.value),
                  blurRadius: 60 * _glow.value,
                  spreadRadius: 8,
                  offset: const Offset(-10, 10),
                ),
              ],
            ),
            child: child,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // Photo
                Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                // Subtle gradient overlay at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppTheme.dark.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                // Flutter badge overlay
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.dark.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppTheme.flutterSky.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppTheme.flutterSky,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Flutter Developer',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11,
                            color: AppTheme.flutterSky,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Content Panel ────────────────────────────────────────────────────────────
class _ContentPanel extends StatelessWidget {
  const _ContentPanel();

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Headline
        Text(
          _aboutHeadline,
          style: GoogleFonts.sora(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.white,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),

        // Detail
        Text(
          _aboutDetail,
          style: GoogleFonts.sora(
            fontSize: 14,
            color: AppTheme.textMuted,
            height: 2.0,
            letterSpacing: 0.3,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 36),

        // Divider
        Container(height: 1, color: Colors.grey[850]),
        const SizedBox(height: 28),

        // Technologies
        Text(
          'Technologies I have worked with:',
          style: GoogleFonts.sora(
            fontSize: 13,
            color: AppTheme.accentAmber,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _tools.map((t) => _TechChip(t)).toList(),
        ),
        const SizedBox(height: 28),

        // Divider
        Container(height: 1, color: Colors.grey[850]),
        const SizedBox(height: 28),

        // Personal Info Grid
        _PersonalInfoGrid(),
        const SizedBox(height: 36),

        // Actions Row
        Wrap(
          spacing: 16,
          runSpacing: 14,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // Resume Button
            _ResumeButton(
                onTap: () => _launch(
                    'https://drive.google.com/file/d/1bqQxdAwIXVG4ONK1TQQhoEl2OcnicvsT/view?usp=drive_link')),

            // Divider line
            Container(
              width: 40,
              height: 1,
              color: Colors.grey[800],
            ),

            // Social Links
            ..._socialLinks.map((s) => _SocialBtn(
                  label: s['label']!,
                  symbol: s['icon']!,
                  url: s['url']!,
                  onTap: () => _launch(s['url']!),
                )),
          ],
        ),
      ],
    );
  }
}

// ─── Tech Chip ────────────────────────────────────────────────────────────────
class _TechChip extends StatefulWidget {
  final String label;
  const _TechChip(this.label);

  @override
  State<_TechChip> createState() => _TechChipState();
}

class _TechChipState extends State<_TechChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: _hovered
              ? AppTheme.flutterBlue.withOpacity(0.18)
              : AppTheme.flutterBlue.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered
                ? AppTheme.flutterSky.withOpacity(0.5)
                : AppTheme.flutterSky.withOpacity(0.18),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: _hovered ? AppTheme.flutterSky : AppTheme.flutterDart,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 7),
            Text(
              widget.label,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                color: _hovered ? AppTheme.flutterSky : AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Personal Info Grid ───────────────────────────────────────────────────────
class _PersonalInfoGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    if (isMobile) {
      return Column(
        children: _personalInfo
            .map((e) => _InfoRow(label: e['label']!, value: e['value']!))
            .toList(),
      );
    }
    // Two-column layout
    final left = _personalInfo.sublist(0, (_personalInfo.length / 2).ceil());
    final right = _personalInfo.sublist((_personalInfo.length / 2).ceil());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: left
                .map((e) => _InfoRow(label: e['label']!, value: e['value']!))
                .toList(),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: right
                .map((e) => _InfoRow(label: e['label']!, value: e['value']!))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                color: AppTheme.flutterSky,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Text(
            ':  ',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 11,
              color: AppTheme.textMuted,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.sora(
                fontSize: 13,
                color: AppTheme.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Resume Button ────────────────────────────────────────────────────────────
class _ResumeButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ResumeButton({required this.onTap});

  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
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
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered ? AppTheme.flutterSky : AppTheme.flutterBlue,
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppTheme.flutterBlue.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [],
          ),
          child: Text(
            'RESUME',
            style: GoogleFonts.sora(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _hovered ? AppTheme.flutterSky : AppTheme.textPrimary,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Social Button ────────────────────────────────────────────────────────────
class _SocialBtn extends StatefulWidget {
  final String label, symbol, url;
  final VoidCallback onTap;

  const _SocialBtn({
    required this.label,
    required this.symbol,
    required this.url,
    required this.onTap,
  });

  @override
  State<_SocialBtn> createState() => _SocialBtnState();
}

class _SocialBtnState extends State<_SocialBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 40,
            height: 40,
            transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppTheme.flutterSky.withOpacity(0.12)
                  : AppTheme.cardBg,
              border: Border.all(
                color: _hovered
                    ? AppTheme.flutterSky.withOpacity(0.5)
                    : AppTheme.flutterSky.withOpacity(0.15),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                widget.symbol,
                style: TextStyle(
                  fontSize: widget.symbol.length == 2 ? 11 : 14,
                  color: _hovered ? AppTheme.flutterSky : AppTheme.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
