// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:dio/dio.dart';
// import 'package:frontend/features/core/constants/api_constants.dart';
// import 'auth_controller.dart';

// final qrControllerProvider = StateNotifierProvider<QrController, QrState>((
//   ref,
// ) {
//   return QrController(ref);
// });

// class QrState {
//   final String? qrData;
//   final String? sessionId;
//   final int? expiresIn;
//   final bool loading;

//   QrState({this.qrData, this.sessionId, this.expiresIn, this.loading = false});

//   QrState copyWith({
//     String? qrData,
//     String? sessionId,
//     int? expiresIn,
//     bool? loading,
//   }) {
//     return QrState(
//       qrData: qrData ?? this.qrData,
//       sessionId: sessionId ?? this.sessionId,
//       expiresIn: expiresIn ?? this.expiresIn,
//       loading: loading ?? this.loading,
//     );
//   }
// }

// class QrController extends StateNotifier<QrState> {
//   final Ref ref;

//   QrController(this.ref) : super(QrState());

//   final Dio dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

//   Future<void> generateQr() async {
//     final authState = ref.read(authControllerProvider);
//     final token = authState
//         .preAuthToken; //The getter 'preAuthToken' isn't defined for the type 'AuthState'.
//     // Try importing the library that defines 'preAuthToken', correcting the name to the name of an existing getter, or defining a getter or field named 'preAuthToken'.dartundefined_getter

//     if (token == null) return;

//     state = state.copyWith(loading: true);

//     try {
//       /// STEP 1 — Create session
//       final sessionRes = await dio.post(
//         "/api/v1/auth/session/init",
//         data: {"authType": "QR"},
//         options: Options(headers: {"Authorization": "Bearer $token"}),
//       );

//       final sessionId = sessionRes.data['data']['sessionId'];

//       /// STEP 2 — Generate QR
//       final qrRes = await dio.post(
//         "/api/v1/auth/qr/generate",
//         queryParameters: {"sessionId": sessionId},
//         options: Options(headers: {"Authorization": "Bearer $token"}),
//       );

//       state = state.copyWith(
//         qrData: qrRes.data['data']['deeplink'],
//         sessionId: sessionId,
//         expiresIn: qrRes.data['data']['expiresIn'],
//         loading: false,
//       );
//     } catch (e) {
//       state = state.copyWith(loading: false);
//     }
//   }
// }
