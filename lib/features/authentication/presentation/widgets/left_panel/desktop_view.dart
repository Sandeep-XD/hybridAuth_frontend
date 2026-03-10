import 'package:flutter/material.dart';

class LeftPanelDesktopView extends StatelessWidget {
  final VoidCallback onKnowMore;

  const LeftPanelDesktopView({super.key, required this.onKnowMore});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 100),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TOP TITLE
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Digital Arrest is Fake!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    "Genuine officers will never detain you\nor ask for money",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),

                  // const SizedBox(height: 20),
                ],
              ),

              //CENTER IMAGE
              Expanded(
                child: Image.asset(
                  "assets/images/computer.png",
                  width: 500,
                  fit: BoxFit.contain,
                ),
              ),

              // const SizedBox(height: 30),

              // BOTTOM TEXT
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "When in doubt reach out to your bank.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),

                  // const SizedBox(height: 8),
                  const Text(
                    "Click here to know more about investment and APK Fraud",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),

                  const SizedBox(height: 20),

                  /// BUTTON
                  InkWell(
                    onTap: onKnowMore,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            const Color.fromARGB(255, 100, 149, 241),
                            const Color.fromARGB(255, 5, 63, 162),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.white),
                      ),
                      child: const Text(
                        "Know More",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
