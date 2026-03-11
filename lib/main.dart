import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/authentication/presentation/providers/auth_controller.dart';
import 'features/authentication/presentation/providers/auth_state.dart';
import 'features/authentication/presentation/widgets/right_panel/dashboardpage.dart';
import 'features/authentication/presentation/pages/layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/env/.env");

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
