import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../providers/auth_controller.dart';
import '../../providers/auth_state.dart';

class QRLoginPopup extends ConsumerStatefulWidget {
  const QRLoginPopup({super.key});

  @override
  ConsumerState<QRLoginPopup> createState() => _QRLoginPopupState();
}

class _QRLoginPopupState extends ConsumerState<QRLoginPopup> {
  int secondsRemaining = 30;
  Timer? timer;
  late final AuthController notifier;

  @override
  void initState() {
    super.initState();

    notifier = ref.read(authControllerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifier.setQrActive(true);
      notifier.startSession("QR");
    });

    startTimer();
  }

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() => secondsRemaining--);
      } else {
        timer.cancel();
        notifier.stopPolling();
      }
    });
  }

  void refreshQR() {
    notifier.stopPolling();
    notifier.startSession("QR");

    setState(() {
      secondsRemaining = 30;
    });

    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    notifier.stopPolling();
    notifier.setQrActive(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next.stage == AuthStage.authenticated && mounted) {
        Navigator.pop(context);
      }
    });

    final bool isExpired = secondsRemaining == 0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),

      child: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Login via QR Code",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              /// DESCRIPTION
              const Text(
                "Use your New HDFC Early Access App to scan the QR AND log in.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 6),

              const Text(
                "Authenticate will happen via the App, not your NetBanking Customer ID.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),

              const SizedBox(height: 16),

              /// APP BADGES
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/app_store.png", height: 40),
                  const SizedBox(width: 12),
                  Image.asset("assets/images/play_store.png", height: 40),
                ],
              ),

              const SizedBox(height: 16),

              const Divider(),

              const SizedBox(height: 16),

              /// QR CONTAINER
              Container(
                width: 260,
                height: 260,
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: const Color(0xffE6EEF4),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    /// QR
                    authState.stage == AuthStage.qrReady &&
                            authState.qrDeepLink != null
                        ? Opacity(
                            opacity: isExpired ? 0.2 : 1,
                            child: QrImageView(
                              data: authState.qrDeepLink!,
                              size: 220,
                            ),
                          )
                        : const CircularProgressIndicator(),

                    /// BLUR + REFRESH
                    if (isExpired)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: refreshQR,
                            icon: const Icon(Icons.refresh),
                            label: const Text("Refresh"),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              /// TIMER
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    isExpired
                        ? "QR expired"
                        : "Refreshes in $secondsRemaining sec",
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// HELP LINK
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Trouble scanning the QR Code?",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
