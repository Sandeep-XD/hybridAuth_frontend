import 'package:flutter/material.dart';
import 'dart:ui';
import '../right_panel/header_section.dart';
import '../right_panel/mobile_field.dart';
import '../right_panel/identify_section.dart';
import '../right_panel/qr_section.dart';
import '../right_panel/security_banner.dart';
import '../right_panel/login_button.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  bool _isMobileValid = false;
  bool _isIdentifyValid = false;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520, minWidth: 300),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),

              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 32 : 22,
                  vertical: isDesktop ? 36 : 28,
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),

                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.35),
                      Colors.white.withOpacity(0.12),
                    ],
                  ),

                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 1.4,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    /// HEADER
                    const HeaderSection(),

                    const SizedBox(height: 12),

                    /// QR LOGIN OPTION
                    const QrLoginSection(),

                    const SizedBox(height: 28),

                    /// MOBILE FIELD
                    MobileField(
                      onValidationChanged: (isValid) {
                        setState(() {
                          _isMobileValid = isValid;
                        });
                      },
                    ),

                    const SizedBox(height: 14),

                    /// IDENTIFY USER (PAN / DOB)
                    IdentifySection(
                      onValidationChanged: (isValid) {
                        setState(() {
                          _isIdentifyValid = isValid;
                        });
                      },
                    ),

                    const SizedBox(height: 32),

                    /// SECURITY BANNER
                    const SecurityBanner(),

                    const SizedBox(height: 20),

                    /// LOGIN BUTTON
                    LoginButton(isEnabled: _isMobileValid && _isIdentifyValid),

                    const SizedBox(height: 12),

                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
