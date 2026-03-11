import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? (throw Exception('http://ad470f3aa1cea4a0195ee309b31fe5bb-1883728287.ap-south-1.elb.amazonaws.com/api/v1'));



  static const authInit = "/auth/init";

  static const identify = "/user/details/identify";

  static const sessionInit = "/auth/session/init";

  static const sessionFetch = "/auth/session/fetch";

  static const qrGenerate = "/auth/qr/generate";

  static const otpInit = "/auth/otp/init";

  static const otpValidate = "/auth/otp/validate";

  static const authToken = "/auth/token";
}
