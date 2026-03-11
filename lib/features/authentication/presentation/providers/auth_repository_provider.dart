import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/token_storage.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../domain/repository/auth_repository.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  final storage = ref.read(tokenStorageProvider);

  return DioClient(storage);
});
final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dioClient = ref.read(dioClientProvider);
  final storage = ref.read(tokenStorageProvider);

  return AuthRepositoryImpl(dioClient, storage);
});
