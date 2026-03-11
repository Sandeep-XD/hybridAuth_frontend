import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../presentation/providers/auth_controller.dart';

class DashboardPage extends ConsumerWidget {
  final String userName;

  const DashboardPage({super.key, this.userName = "Abdul Mansoori"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      /// APP BAR
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 23, 59),
        toolbarHeight: 80,
        title: Row(
          children: [
            Image.asset("assets/images/hdfc_logo.png", width: 140, height: 140),
            const SizedBox(width: 15),
            const Text(
              "NetBanking",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).logout();

              if (context.mounted) {
                Navigator.pushReplacementNamed(context, "/");
              }
            },
          ),
        ],
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// GREETING
            Text(
              "Welcome back,",
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
            ),

            Text(
              userName,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            /// ACCOUNT CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 23, 59),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Savings Account",
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "₹ 2,45,300.00",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "A/C XXXX 2883",
                    style: TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// QUICK ACTIONS
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: const [
                _ActionTile(icon: Icons.send, label: "Transfer"),
                _ActionTile(icon: Icons.receipt, label: "Pay Bills"),
                _ActionTile(icon: Icons.account_balance, label: "Accounts"),
                _ActionTile(icon: Icons.qr_code, label: "Scan & Pay"),
                _ActionTile(icon: Icons.history, label: "Transactions"),
                _ActionTile(icon: Icons.support_agent, label: "Support"),
              ],
            ),

            const SizedBox(height: 30),

            /// RECENT ACTIVITY
            const Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const ListTile(
              leading: Icon(Icons.arrow_upward, color: Colors.red),
              title: Text("Amazon Payment"),
              subtitle: Text("Today"),
              trailing: Text("- ₹2,300"),
            ),

            const ListTile(
              leading: Icon(Icons.arrow_downward, color: Colors.green),
              title: Text("Salary Credit"),
              subtitle: Text("Yesterday"),
              trailing: Text("+ ₹45,000"),
            ),
          ],
        ),
      ),
    );
  }
}

/// QUICK ACTION TILE
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.blueGrey),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
