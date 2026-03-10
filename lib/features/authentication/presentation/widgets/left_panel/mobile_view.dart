import 'package:flutter/material.dart';

class LeftPanelMobileView extends StatelessWidget {
  final VoidCallback onKnowMore;

  const LeftPanelMobileView({super.key, required this.onKnowMore});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Digital Arrest is Fake!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Click here to know more about investment and APK Fraud",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),

                  const SizedBox(height: 20),

                  InkWell(
                    onTap: onKnowMore,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white),
                      ),
                      child: const Text(
                        "Know More",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/images/computer.png",
                  width: 500,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
