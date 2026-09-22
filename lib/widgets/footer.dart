import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});


    Stream<int> getVisitorCount() {
    return FirebaseFirestore.instance
        .collection('visitors')
        .doc('pagecounter')
        .snapshots()
        .map((snapshot) => snapshot.get('count'));
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final pad = Responsive.contentPadding(context);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.flutterSky.withOpacity(0.1)),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: 36),
      child: isMobile
          ? Column(
              children: [
                _Logo(),
                const SizedBox(height: 12),
                _Copyright(),
                      const SizedBox(height: 6),
            StreamBuilder<int>(
              stream: getVisitorCount(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("Visitors: ...");
                }

                return Text(
                  "Total Visitors: ${snapshot.data}",
                  style: const TextStyle(fontSize: 12),
                );
              },
            )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Logo(),
                _Copyright(),
                      const SizedBox(width: 6),
            StreamBuilder<int>(
              stream: getVisitorCount(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("Visitors: ...");
                }

                return Text(
                  "Total Visitors: ${snapshot.data}",
                  style: const TextStyle(fontSize: 12),
                );
              },
            )
              ],
            ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'S.',
            style: GoogleFonts.jetBrainsMono(
              color: AppTheme.textMuted,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: 'Amarjit',
            style: GoogleFonts.jetBrainsMono(
              color: AppTheme.flutterSky,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: '.dev',
            style: GoogleFonts.jetBrainsMono(
              color: AppTheme.textMuted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _Copyright extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '© 2026 Sarangthem Amarjit Meetei  ·  Built with Flutter ❤️',
      style: GoogleFonts.jetBrainsMono(
        fontSize: 11,
        color: AppTheme.textMuted,
      ),
    );
  }
}
