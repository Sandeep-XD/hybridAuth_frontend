import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/responsive.dart';
import '../widgets/left_panel/left_panel.dart';
import '../widgets/right_panel/login_right_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/auth_controller.dart';
import '../providers/auth_state.dart';

class LoginResponsiveLayout extends ConsumerStatefulWidget {
  const LoginResponsiveLayout({super.key});

  @override
  ConsumerState<LoginResponsiveLayout> createState() =>
      _LoginResponsiveLayoutState();
}

class _LoginResponsiveLayoutState extends ConsumerState<LoginResponsiveLayout> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //calling the controller , accessing the contrller 
      final controller = ref.read(authControllerProvider.notifier);
//checking if the user ons loogin 
      await controller.checkExistingAuth();


      final authState = ref.read(authControllerProvider);
      if (authState.stage != AuthStage.authenticated) {
        controller.initAuth();//tells authcaontroller to start working call authcontroller  
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Listen for auth state changes
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (!mounted) return;
      if (next.stage == AuthStage.authenticated) {
        Navigator.pushReplacementNamed(context, "/dashboard");
      }

      if (next.stage == AuthStage.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error ?? "Authentication error")),
        );
      }
    });

    final authState = ref.watch(authControllerProvider);

    if (authState.stage == AuthStage.initializing) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 23, 59),
        toolbarHeight: 80,
        title: Image.asset(
          "assets/images/hdfc_logo.png",
          width: 140,
          height: 140,
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          if (Responsive.isDesktop(context)) {
            return const Row(
              children: [
                Expanded(flex: 4, child: LeftPanel()),
                Expanded(flex: 5, child: LoginRightPanel()),
              ],
            );
          }

          return const Column(
            children: [
              SizedBox(child: LeftPanel()),
              Expanded(child: LoginRightPanel()),
            ],
          );
        },
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        color: const Color.fromARGB(255, 34, 47, 86),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              const TextSpan(
                text:
                    " 🍪 We use cookies to enhance your digital banking experience. "
                    "By browsing this site, you agree to our use of cookies. ",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              TextSpan(
                text: "View cookie policy",
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w400,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl(
                      Uri.parse("https://www.hdfcbank.com/cookie-policy"),
                    );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
