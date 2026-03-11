import 'package:flutter/material.dart';
import 'login_card.dart';
import 'bottom_register.dart';

class LoginRightPanel extends StatelessWidget {
  const LoginRightPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // C Added GestureDetector to dismiss keyboard on tap
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          const _BackgroundLayer(),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoginCard(),
                  const SizedBox(height: 10),
                  const BottomRowRegister()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BackgroundLayer extends StatelessWidget {
  const _BackgroundLayer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        backgroundBlendMode: BlendMode.darken,
        color: Color.fromARGB(255, 255, 255, 255),
        image: DecorationImage(
          image: AssetImage("assets/images/right_panel_background.png"),
          fit: BoxFit.cover,
        ),
      ),

      foregroundDecoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.white60, Colors.transparent],
        ),
      ),
    );
  }
}
