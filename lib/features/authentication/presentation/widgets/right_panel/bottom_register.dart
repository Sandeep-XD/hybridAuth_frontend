import 'package:flutter/material.dart';
import '../right_panel/register_page.dart';

class BottomRowRegister extends StatelessWidget {
  const BottomRowRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Not Registered for NetBanking? ",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
          },
          child: const Text(
            "Register Now",
            style: TextStyle(
              fontSize: 17,
              color: Color.fromARGB(255, 25, 37, 206),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}