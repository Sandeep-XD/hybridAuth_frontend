enum AuthStage {//stores authentication stages 
  initial,
  initializing,
  preAuthReady,
  sessionPending,
  identifyingUser,
  userIdentified,
  qrLoading,
  qrReady,
  authenticated,
  error,
}

class AuthState { //represents complte authentication state of the app
  final AuthStage stage;

  final String? sessionId;

  final String? qrDeepLink;

  final int? qrExpiresIn;

  final String? error;

  final bool isQrActive;

  const AuthState({
    required this.stage,
    this.sessionId,
    this.qrDeepLink,
    this.qrExpiresIn,
    this.error,
    this.isQrActive = false,
  });

  AuthState copyWith({ 
    AuthStage? stage,
    String? sessionId,
    String? qrDeepLink,
    int? qrExpiresIn,
    String? error,
    bool? isQrActive,
    bool clearError = false,
  }) {
    return AuthState(
      stage: stage ?? this.stage,
      sessionId: sessionId ?? this.sessionId,
      qrDeepLink: qrDeepLink ?? this.qrDeepLink,
      qrExpiresIn: qrExpiresIn ?? this.qrExpiresIn,
      error: clearError ? null : error ?? this.error,
      isQrActive: isQrActive ?? this.isQrActive,
    );
  }
}
