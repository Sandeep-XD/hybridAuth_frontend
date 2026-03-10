import 'package:flutter/material.dart';
import '../right_panel/qr_login_popup.dart';

class QrLoginSection extends StatelessWidget {
  const QrLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.4),
        // color: Colors.white.withOpacity(0.10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return const QRLoginPopup(); // This is your class from ../right_panel/qr_login_popup.dart
                },
              );
            },
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.qr_code_scanner,
                size: 32,
                color: Colors.blue.shade800,
              ),
            ),
          ),
          const SizedBox(width: 16),

          //  TEXT SECTION
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Click to scan QR and login",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  "New HDFC Bank Early Access App required",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),

          // NEW BADGE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.star, size: 20, color: Colors.yellow),
                SizedBox(width: 4),
                Text(
                  "NEW",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //pop up
  // void _showScannerPopup(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // Recommended since your popup is for login
  //     builder: (context) {
  //       return const QRLoginPopup();
  //     },
  //   );
  // }
}
