abstract class AuthRepository {
  Future<String> initAuth();

  Future<void> savePreAuthToken(String token);

  Future<Map<String, dynamic>> initSession(String authType);

  Future<Map<String, dynamic>> identifyUser(
    String mobile,
    String pan,
    String dob,
    String sessionId,
  );

  Future<Map<String, dynamic>> generateQr(String sessionId);

  Future<String> fetchSession(String sessionId);

  Future<String> exchangeToken(String sessionId);

  Future<void> saveUserToken(String token);
  Future<String?> getSavedUserToken();

  Future<void> clearUserToken();
}
