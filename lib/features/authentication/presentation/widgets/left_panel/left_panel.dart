import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/responsive.dart';
import 'mobile_view.dart';
import 'desktop_view.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  Future<void> _openExternalLink() async {
    final Uri url = Uri.parse('https://www.hdfc.bank.in/security-measures');

    if (!await launchUrl(url, webOnlyWindowName: '_blank')) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 42, 35, 135),
                  Color.fromARGB(255, 42, 69, 157),
                  Color.fromARGB(255, 22, 87, 162),
                ],
              ),
            ),
          ),
        ),

        // CALL DIFFERENT VIEW
        // Positioned.fill(
        //   child: isDesktop
        //       ? LeftPanelDesktopView(onKnowMore: _openExternalLink)
        //       : LeftPanelMobileView(onKnowMore: _openExternalLink),
        // ),
        isDesktop
            ? SizedBox(
                height: double.infinity,
                child: LeftPanelDesktopView(onKnowMore: _openExternalLink),
              )
            : LeftPanelMobileView(onKnowMore: _openExternalLink),
      ],
    );
  }
}
