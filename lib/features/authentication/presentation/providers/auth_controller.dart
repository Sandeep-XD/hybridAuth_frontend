import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/presentation/providers/auth_repository_provider.dart';
import '../../domain/repository/auth_repository.dart';
import 'auth_state.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final repo = ref.read(authRepositoryProvider);
    return AuthController(repo);
  },
);//this create global state provider ui can access authcontrller and listen to authstate

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository repository;

  Timer? _pollTimer;
  int _pollAttempts = 0;

  AuthController(this.repository)
    : super(const AuthState(stage: AuthStage.initial));
  Future<void> checkExistingAuth() async {
    try {
      final token = await repository
          .getSavedUserToken(); 

      if (token != null) {
        state = state.copyWith(stage: AuthStage.authenticated);//set stage
      }
    } catch (_) {}
  }

  // STEP 1
  Future<void> initAuth() async {
    try {
      state = state.copyWith(stage: AuthStage.initializing);
//// YOU ARE CALLING THE REPOSITORY DIRECTLY HERE:
      final token = await repository.initAuth();
      await repository.savePreAuthToken(token);

      state = state.copyWith(stage: AuthStage.preAuthReady);
    } catch (e) {
      state = state.copyWith(stage: AuthStage.error, error: e.toString());
    }
  }

  /// STEP 2
  Future<void> identifyUser(String mobile, String pan, String dob) async {
    try {
      if (state.sessionId == null) {
        await initAuth();
        await startSession("QR");
      }

      state = state.copyWith(stage: AuthStage.identifyingUser);

      await repository.identifyUser(mobile, pan, dob, state.sessionId!);

      state = state.copyWith(stage: AuthStage.userIdentified);
    } catch (e) {
      state = state.copyWith(stage: AuthStage.error, error: e.toString());
    }
  }

  /// STEP 3
  Future<void> startSession(String authType) async {
    try {
      final session = await repository.initSession(authType);

      final sessionId = session["sessionId"];

      state = state.copyWith(
        stage: AuthStage.sessionPending,
        sessionId: sessionId,
      );

      if (authType == "QR") {
        await generateQr(sessionId);
      }
    } catch (e) {
      state = state.copyWith(stage: AuthStage.error, error: e.toString());
    }
  }

  /// STEP 4
  Future<void> generateQr(String sessionId) async {
    try {
      final qr = await repository.generateQr(sessionId);

      state = state.copyWith(
        stage: AuthStage.qrReady,
        qrDeepLink: qr["deeplink"],
        isQrActive: true, // ⭐ IMPORTANT
      );

      _startPolling(sessionId);
    } catch (e) {
      state = state.copyWith(stage: AuthStage.error, error: e.toString());
    }
  }

  /// STEP 5
  void _startPolling(String sessionId) {
    _pollTimer?.cancel();
    _pollTimer = null;

    _pollAttempts = 0;

    _pollTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (!state.isQrActive) {
        timer.cancel();
        return;
      }

      try {
        _pollAttempts++;

        if (_pollAttempts > 40) {
          timer.cancel();
          state = state.copyWith(stage: AuthStage.error);
          return;
        }

        final status = await repository.fetchSession(sessionId);

        print("SESSION STATUS → $status");

        if (status == "APPROVED") {
          timer.cancel();
          await _exchangeToken(sessionId);
        }

        if (status == "REJECTED") {
          timer.cancel();
          state = state.copyWith(stage: AuthStage.error);
        }

        if (status == "EXPIRED") {
          timer.cancel();
          state = state.copyWith(stage: AuthStage.error);
        }
      } catch (e) {
        timer.cancel();
        state = state.copyWith(stage: AuthStage.error);
      }
    });
  }

  /// STEP 6
  Future<void> _exchangeToken(String sessionId) async {
    try {
      final token = await repository.exchangeToken(sessionId);

      await repository.saveUserToken(token);

      state = state.copyWith(stage: AuthStage.authenticated);
    } catch (e) {
      state = state.copyWith(stage: AuthStage.error);
    }
  }

  /// Stop polling for session status
  void stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  /// Set QR active status
  void setQrActive(bool active) {
    state = state.copyWith(isQrActive: active);
  }

  Future<void> logout() async {
    await repository.clearUserToken();
    state = const AuthState(stage: AuthStage.initial);
  }

  @override
  void dispose() {
    _pollTimer?.cancel();

    super.dispose();
  }
}
