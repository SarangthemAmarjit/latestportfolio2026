import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/screencontroller.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'common_widgets.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _phoneCtrl;
  late AnimationController _glowCtrl;
  late Animation<double> _phoneBob;
  late Animation<double> _glowPulse;
  late AnimationController _barCtrl;
  late Animation<double> _bar1, _bar2, _bar3;

  @override
  void initState() {
    super.initState();
    _phoneCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _phoneBob = Tween<double>(begin: 0, end: -14).animate(
      CurvedAnimation(parent: _phoneCtrl, curve: Curves.easeInOut),
    );

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _glowPulse = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    _barCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _bar1 = Tween<double>(begin: 0.3, end: 0.9).animate(
      CurvedAnimation(parent: _barCtrl, curve: Curves.easeInOut),
    );
    _bar2 = Tween<double>(begin: 0.5, end: 0.75).animate(
      CurvedAnimation(
        parent: _barCtrl,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
      ),
    );
    _bar3 = Tween<double>(begin: 0.6, end: 0.88).animate(
      CurvedAnimation(
        parent: _barCtrl,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _glowCtrl.dispose();
    _barCtrl.dispose();
    super.dispose();
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final ScreenController sccon = Get.put(ScreenController());
    final isMobile = Responsive.isMobile(context);
    final pad = Responsive.contentPadding(context);

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeInUp(
          duration: const Duration(milliseconds: 700),
          child: _AvailableBadge(),
        ),
        const SizedBox(height: 28),
        FadeInUp(
          delay: const Duration(milliseconds: 100),
          child: _HeroName(),
        ),
        const SizedBox(height: 14),
        FadeInUp(
          delay: const Duration(milliseconds: 200),
          child: _HeroTitle(),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          delay: const Duration(milliseconds: 300),
          child: _HeroBio(),
        ),
        const SizedBox(height: 36),
        FadeInUp(
          delay: const Duration(milliseconds: 400),
          child: Wrap(
            spacing: 14,
            runSpacing: 12,
            children: [
              GradientButton(
                label: 'View Projects',
                icon: '↓',
                onTap: () {
                  sccon.scrollTo('projects');
                },
              ),
              GradientButton(
                label: '📝  Get Biodata',
                outline: true,
                onTap: () => _launch(
                    'https://drive.google.com/file/d/1bqQxdAwIXVG4ONK1TQQhoEl2OcnicvsT/view?usp=drive_link'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        FadeInUp(
          delay: const Duration(milliseconds: 500),
          child: _SocialStrip(onLaunch: _launch),
        ),
      ],
    );

    if (isMobile) {
      return Padding(
        padding: EdgeInsets.fromLTRB(pad, 100, pad, 60),
        child: Column(
          children: [
            content,
            const SizedBox(height: 60),
            _PhoneMockup(
              phoneBob: _phoneBob,
              glowPulse: _glowPulse,
              bar1: _bar1,
              bar2: _bar2,
              bar3: _bar3,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(pad, 110, pad, 80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: content),
          const SizedBox(width: 60),
          FadeInRight(
            delay: const Duration(milliseconds: 200),
            child: _PhoneMockup(
              phoneBob: _phoneBob,
              glowPulse: _glowPulse,
              bar1: _bar1,
              bar2: _bar2,
              bar3: _bar3,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvailableBadge extends StatefulWidget {
  @override
  State<_AvailableBadge> createState() => _AvailableBadgeState();
}

class _AvailableBadgeState extends State<_AvailableBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.4, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.flutterSky.withOpacity(0.08),
        border: Border.all(color: AppTheme.flutterSky.withOpacity(0.25)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) => Opacity(
              opacity: _pulse.value,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppTheme.flutterSky,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Available for work',
            style: GoogleFonts.jetBrainsMono(
              color: AppTheme.flutterSky,
              fontSize: 12,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = Responsive.isMobile(context) ? 42.0 : 60.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sarangthem',
          style: GoogleFonts.sora(
            fontSize: size,
            fontWeight: FontWeight.w800,
            color: AppTheme.white,
            letterSpacing: 1,
            height: 1.05,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppTheme.flutterSky,
              AppTheme.flutterDart,
              AppTheme.flutterBlue
            ],
          ).createShader(bounds),
          child: Text(
            'Amarjit Meetei',
            style: GoogleFonts.sora(
              fontSize: size,
              fontWeight: FontWeight.w800,
              color: AppTheme.white,
              height: 1.05,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Flutter Developer ',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 15,
              color: AppTheme.accentAmber,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: '& Software Engineer',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 15,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Text(
        'Building elegant, user-friendly mobile & web solutions with Flutter and Dart. '
        'Fast learner who adapts quickly to new technologies, delivering high-quality results that add real value.',
        style: GoogleFonts.sora(
          fontSize: 15,
          color: AppTheme.textMuted,
          height: 1.8,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

class _SocialStrip extends StatelessWidget {
  final Future<void> Function(String) onLaunch;
  const _SocialStrip({required this.onLaunch});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'CONNECT',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 10,
            color: AppTheme.textMuted,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(width: 14),
        Container(
            width: 30, height: 1, color: AppTheme.flutterSky.withOpacity(0.2)),
        const SizedBox(width: 14),
        _SocialIcon(
          icon: Icons.code,
          tooltip: 'GitHub',
          onTap: () => onLaunch('https://github.com/SarangthemAmarjit'),
        ),
        const SizedBox(width: 10),
        _SocialIcon(
          icon: Icons.work_outline,
          tooltip: 'LinkedIn',
          onTap: () => onLaunch('https://www.linkedin.com/in/sarang-amar'),
        ),
        const SizedBox(width: 10),
        // _SocialIcon(
        //   icon: Icons.language,
        //   tooltip: 'Portfolio',
        //   onTap: () => onLaunch('https://amarjit.web.app'),
        // ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 38,
            height: 38,
            transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppTheme.flutterSky.withOpacity(0.1)
                  : Colors.transparent,
              border: Border.all(
                color: _hovered
                    ? AppTheme.flutterSky.withOpacity(0.5)
                    : AppTheme.flutterSky.withOpacity(0.15),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              widget.icon,
              size: 16,
              color: _hovered ? AppTheme.flutterSky : AppTheme.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneMockup extends StatelessWidget {
  final Animation<double> phoneBob;
  final Animation<double> glowPulse;
  final Animation<double> bar1, bar2, bar3;

  const _PhoneMockup({
    required this.phoneBob,
    required this.glowPulse,
    required this.bar1,
    required this.bar2,
    required this.bar3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 460,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow
          AnimatedBuilder(
            animation: glowPulse,
            builder: (_, __) => Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.flutterBlue.withOpacity(0.3 * glowPulse.value),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Phone
          AnimatedBuilder(
            animation: phoneBob,
            builder: (_, child) => Transform.translate(
              offset: Offset(0, phoneBob.value),
              child: child,
            ),
            child: Transform.rotate(
              angle: -0.035,
              child: Container(
                width: 200,
                height: 400,
                decoration: BoxDecoration(
                  color: AppTheme.dark3,
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(
                    color: AppTheme.flutterSky.withOpacity(0.15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 60,
                      offset: const Offset(0, 30),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: _PhoneScreen(bar1: bar1, bar2: bar2, bar3: bar3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneScreen extends StatelessWidget {
  final Animation<double> bar1, bar2, bar3;
  const _PhoneScreen(
      {required this.bar1, required this.bar2, required this.bar3});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Notch
        Container(
          width: 80,
          height: 20,
          decoration: const BoxDecoration(
            color: AppTheme.dark,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App bar dots
                Row(
                  children: [
                    _Dot(color: const Color(0xFFFF6B6B)),
                    const SizedBox(width: 6),
                    _Dot(color: const Color(0xFFFFD93D)),
                    const SizedBox(width: 6),
                    _Dot(color: const Color(0xFF6BCB77)),
                    const SizedBox(width: 8),
                    Text(
                      'portfolio.dart',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 9,
                        color: AppTheme.flutterSky,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _PhoneWidget(
                  title: 'Flutter Dev',
                  subtitle: 'Dart • Mobile • Web',
                  barAnim: bar1,
                ),
                const SizedBox(height: 8),
                _PhoneWidget(
                  title: 'Experience',
                  subtitle: '2+ years active',
                  barAnim: bar2,
                ),
                const SizedBox(height: 8),
                _PhoneWidget(
                  title: 'Projects',
                  subtitle: '6+ shipped apps',
                  barAnim: bar3,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.flutterBlue.withOpacity(0.1),
                    border: Border.all(
                      color: AppTheme.flutterSky.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'void main() {\n  runApp(Portfolio());\n}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      color: AppTheme.flutterSky.withOpacity(0.7),
                      height: 1.6,
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

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _PhoneWidget extends StatelessWidget {
  final String title, subtitle;
  final Animation<double> barAnim;
  const _PhoneWidget(
      {required this.title, required this.subtitle, required this.barAnim});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.flutterBlue.withOpacity(0.1),
        border: Border.all(color: AppTheme.flutterSky.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: AppTheme.flutterSky,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 3),
          Text(subtitle,
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 8, color: AppTheme.textMuted)),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Container(
              height: 5,
              color: AppTheme.flutterSky.withOpacity(0.15),
              child: AnimatedBuilder(
                animation: barAnim,
                builder: (_, __) => FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: barAnim.value,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
