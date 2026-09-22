import 'package:amarjit_portfolio/controller/screencontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_theme.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/flutter_fab.dart';
import '../widgets/footer.dart';
import '../widgets/hero_section.dart';
import '../widgets/navbar.dart';
import '../widgets/particles_bg.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/stats_bar.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {





  @override
  Widget build(BuildContext context) {
    final ScreenController sccon = Get.put(ScreenController());
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: Stack(
        children: [
          // Background layers
          const Positioned.fill(child: BackgroundMesh()),
          const Positioned.fill(child: ParticlesBackground()),

          // Main scrollable content
          CustomScrollView(
            controller: sccon.scrollCtrl,
            slivers: [
              // Sticky Navbar
              SliverPersistentHeader(
                pinned: true,
                delegate: _NavbarDelegate(
                  scrollController: sccon.scrollCtrl,
                  sectionKeys: sccon.keys,
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Hero
                    SizedBox(
                      key: sccon.keys['hero'],
                      child: const HeroSection(),
                    ),

                    // Stats
                    const StatsBar(),

                    // About Me
                    SizedBox(
                      key: sccon.keys['about'],
                      child: const AboutSection(),
                    ),

                    // Experience
                    SizedBox(
                      key: sccon.keys['experience'],
                      child: const ExperienceSection(),
                    ),

                    // Skills
                    SizedBox(
                      key: sccon.keys['skills'],
                      child: const SkillsSection(),
                    ),

                    // Projects
                    SizedBox(
                      key: sccon.keys['projects'],
                      child: const ProjectsSection(),
                    ),

                    // Education
                    SizedBox(
                      key: sccon.keys['education'],
                      child: const EducationSection(),
                    ),

                    // Contact
                    SizedBox(
                      key: sccon.keys['contact'],
                      child: const ContactSection(),
                    ),

                    // Footer
                    const PortfolioFooter(),
                  ],
                ),
              ),
            ],
          ),

          // Floating Flutter badge
          const Positioned(
            bottom: 32,
            right: 32,
            child: FlutterFAB(),
          ),
        ],
      ),
    );
  }
}

class _NavbarDelegate extends SliverPersistentHeaderDelegate {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  _NavbarDelegate({
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  double get minExtent => 72;

  @override
  double get maxExtent => 72;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return PortfolioNavbar(
      scrollController: scrollController,
      sectionKeys: sectionKeys,
    );
  }

  @override
  bool shouldRebuild(_NavbarDelegate old) => false;
}
