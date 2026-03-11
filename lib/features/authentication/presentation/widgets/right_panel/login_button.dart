import 'package:flutter/material.dart';
import '../right_panel/dashboardpage.dart';

class LoginButton extends StatelessWidget {
  // NEW: 1. Receive the boolean from LoginCard
  final bool isEnabled;

  const LoginButton({
    super.key, 
    this.isEnabled = false, // Default to false for safety
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 47,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        // NEW: 2. If isEnabled is false, onTap is null (disables the click)
        onTap: isEnabled 
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardPage()),
                );
              } 
            : null, 
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // NEW: 3. Make the border gradient look "faded" when disabled
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                isEnabled ? Colors.black.withOpacity(0.4) : Colors.black.withOpacity(0.1),
                isEnabled ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.2),
              ],
            ),
          ),

          // Inner container creating 2px border
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              // NEW: 4. Change the blue fill to Grey when disabled
              color: isEnabled ? const Color(0xFF0F5EA8) : const Color.fromARGB(255, 33, 92, 148),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Text(
                "LOGIN",
                style: TextStyle(
                  // NEW: 5. Fade the text color slightly when disabled
                  color: isEnabled ? Colors.white : Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
