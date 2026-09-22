import 'package:amarjit_portfolio/controller/screencontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'common_widgets.dart';

class PortfolioNavbar extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const PortfolioNavbar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<PortfolioNavbar> createState() => _PortfolioNavbarState();
}

class _PortfolioNavbarState extends State<PortfolioNavbar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      setState(() {
        _scrolled = widget.scrollController.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScreenController sccon = Get.put(ScreenController());
    final isMobile = Responsive.isMobile(context);
    final pad = Responsive.contentPadding(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: 16),
      decoration: BoxDecoration(
        color: _scrolled
            ? AppTheme.dark.withOpacity(0.97)
            : AppTheme.dark.withOpacity(0.85),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.flutterSky.withOpacity(0.12),
          ),
        ),
        boxShadow: _scrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                )
              ]
            : [],
      ),
      child: Row(
        children: [
          // Logo
          InkWell(
            onTap: () => sccon.scrollTo('hero'),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '<',
                    style: GoogleFonts.jetBrainsMono(
                      color: AppTheme.textMuted,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'S.',
                    style: GoogleFonts.jetBrainsMono(
                      color: AppTheme.textMuted,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'Amarjit',
                    style: GoogleFonts.jetBrainsMono(
                      color: AppTheme.flutterSky,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: '/>',
                    style: GoogleFonts.jetBrainsMono(
                      color: AppTheme.textMuted,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          if (!isMobile) ...[
            NavLink(label: 'About', onTap: () => sccon.scrollTo('about')),
            const SizedBox(width: 32),
            NavLink(
                label: 'Experience', onTap: () => sccon.scrollTo('experience')),
            const SizedBox(width: 32),
            NavLink(label: 'Skills', onTap: () => sccon.scrollTo('skills')),
            const SizedBox(width: 32),
            NavLink(label: 'Projects', onTap: () => sccon.scrollTo('projects')),
            const SizedBox(width: 32),
            NavLink(
                label: 'Education', onTap: () => sccon.scrollTo('education')),
            const SizedBox(width: 32),
            NavLink(label: 'Contact', onTap: () => sccon.scrollTo('contact')),
            const SizedBox(width: 32),
          ],
          GradientButton(
            label: isMobile ? 'Hire Me' : 'Hire Me →',
            onTap: () => sccon.scrollTo('contact'),
          ),
          if (isMobile) ...[
            const SizedBox(width: 12),
            PopupMenuButton<String>(
              color: AppTheme.dark3,
              icon: const Icon(Icons.menu, color: AppTheme.textMuted),
              onSelected: (value) => sccon.scrollTo(value),
              itemBuilder: (_) => [
                'about',
                'experience',
                'skills',
                'projects',
                'education',
                'contact'
              ]
                  .map((k) => PopupMenuItem(
                        value: k,
                        child: Text(
                          k[0].toUpperCase() + k.substring(1),
                          style: GoogleFonts.sora(
                            color: AppTheme.textPrimary,
                            fontSize: 13,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
