import 'package:flutter/material.dart';

class SecurityBanner extends StatelessWidget {
  const SecurityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// TEXT SIDE
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Goodbye, Secure Text & Image",
                  style: TextStyle(fontSize: 16, color: Color(0xFF053CB2)),
                ),
                SizedBox(height: 4),
                Text(
                  "Hello, Digicert Security",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E4C7A),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          /// IMAGE SIDE
          Image.asset(
            "assets/images/clock.png",
            height: 120, // Proper size for this banner
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
