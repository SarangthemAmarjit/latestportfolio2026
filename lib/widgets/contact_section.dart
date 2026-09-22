import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/app_data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'common_widgets.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _visible = false;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final pad = Responsive.contentPadding(context);

    return VisibilityDetector(
      key: const Key('contact'),
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
              const SectionTag('Get In Touch'),
              const SizedBox(height: 16),
              SectionTitle(before: "Let's ", highlight: 'Work Together'),
              const SizedBox(height: 60),
              isMobile
                  ? Column(
                      children: [
                        _ContactInfo(visible: _visible, onLaunch: _launch),
                        const SizedBox(height: 40),
                        _StrengthsPanel(visible: _visible),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _ContactInfo(visible: _visible, onLaunch: _launch),
                        ),
                        const SizedBox(width: 60),
                        Expanded(
                          child: _StrengthsPanel(visible: _visible),
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

class _ContactInfo extends StatelessWidget {
  final bool visible;
  final Future<void> Function(String) onLaunch;

  const _ContactInfo({required this.visible, required this.onLaunch});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      (Icons.phone_outlined, 'Phone', '7005191566 / 9436661541', 'tel:7005191566'),
      (Icons.email_outlined, 'Email', 'sarangthemamarjit123@gmail.com',
          'mailto:sarangthemamarjit123@gmail.com'),
      (Icons.code, 'GitHub', 'github.com/SarangthemAmarjit',
          'https://github.com/SarangthemAmarjit'),
    
      (Icons.location_on_outlined, 'Location',
          'Langthabal Lep Makha Leikai, Manipur', ''),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Open to ',
                style: GoogleFonts.sora(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.white,
                  height: 1.4,
                ),
              ),
              TextSpan(
                text: 'exciting opportunities ',
                style: GoogleFonts.sora(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.flutterSky,
                  height: 1.4,
                ),
              ),
              TextSpan(
                text: 'in mobile & web development.',
                style: GoogleFonts.sora(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.white,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "I'm passionate about building elegant Flutter applications that solve real problems. "
          "Whether it's a new project, collaboration, or just a conversation about tech — feel free to reach out!",
          style: GoogleFonts.sora(
            fontSize: 14,
            color: AppTheme.textMuted,
            height: 1.8,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 36),
        ...contacts.asMap().entries.map((e) {
          final delay = Duration(milliseconds: e.key * 80);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _AnimatedContactItem(
              icon: e.value.$1,
              label: e.value.$2,
              value: e.value.$3,
              url: e.value.$4,
              visible: visible,
              delay: delay,
              onTap: e.value.$4.isNotEmpty ? () => onLaunch(e.value.$4) : null,
            ),
          );
        }),
      ],
    );
  }
}

class _AnimatedContactItem extends StatefulWidget {
  final IconData icon;
  final String label, value, url;
  final bool visible;
  final Duration delay;
  final VoidCallback? onTap;

  const _AnimatedContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
    required this.visible,
    required this.delay,
    this.onTap,
  });

  @override
  State<_AnimatedContactItem> createState() => _AnimatedContactItemState();
}

class _AnimatedContactItemState extends State<_AnimatedContactItem>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(-0.2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_AnimatedContactItem old) {
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
          cursor: widget.onTap != null
              ? SystemMouseCursors.click
              : MouseCursor.defer,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.translationValues(_hovered ? 4 : 0, 0, 0),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _hovered
                      ? AppTheme.flutterSky.withOpacity(0.3)
                      : AppTheme.flutterSky.withOpacity(0.1),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppTheme.flutterBlue.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(widget.icon, size: 16, color: AppTheme.flutterSky),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label.toUpperCase(),
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 9,
                            color: AppTheme.textMuted,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.value,
                          style: GoogleFonts.sora(
                            fontSize: 13,
                            color: AppTheme.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (widget.onTap != null)
                    Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: AppTheme.textMuted.withOpacity(_hovered ? 1 : 0.3),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StrengthsPanel extends StatelessWidget {
  final bool visible;
  const _StrengthsPanel({required this.visible});

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💪  Key Strengths',
            style: GoogleFonts.sora(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.white,
            ),
          ),
          const SizedBox(height: 24),
          ...AppData.strengths.asMap().entries.map((e) {
            return _StrengthItem(
              index: e.key + 1,
              text: e.value,
              isLast: e.key == AppData.strengths.length - 1,
            );
          }),
          const SizedBox(height: 24),
          Container(
            height: 1,
            color: AppTheme.flutterSky.withOpacity(0.1),
          ),
          const SizedBox(height: 24),
          Text(
            'INTERESTS',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              color: AppTheme.textMuted,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              SkillTag('🖥️  Programming'),
              SkillTag('📱  App Development'),
              SkillTag('🌐  Web Development'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StrengthItem extends StatelessWidget {
  final int index;
  final String text;
  final bool isLast;

  const _StrengthItem({
    required this.index,
    required this.text,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.flutterSky.withOpacity(0.08),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '0$index',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: AppTheme.flutterSky,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.sora(
                  fontSize: 13,
                  color: AppTheme.textMuted,
                  height: 1.7,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
        if (!isLast) ...[
          const SizedBox(height: 16),
          Container(height: 1, color: AppTheme.flutterSky.withOpacity(0.08)),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
