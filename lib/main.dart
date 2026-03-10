import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/authentication/presentation/providers/auth_controller.dart';
import 'package:frontend/features/authentication/presentation/providers/auth_state.dart';
import 'package:frontend/features/authentication/presentation/widgets/right_panel/dashboardpage.dart';
import './features/authentication/presentation/pages/layout.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hybrid Authentication",
      initialRoute: "/",
      home: Consumer(
        builder: (context, ref, _) {
          final authState = ref.watch(authControllerProvider);

          if (authState.stage == AuthStage.authenticated) {
            return const DashboardPage();
          }

          return const LoginResponsiveLayout();
        },
      ),

 
    );
  }
}
