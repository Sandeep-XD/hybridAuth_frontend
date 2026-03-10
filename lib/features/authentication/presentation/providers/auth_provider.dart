import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/features/authentication/presentation/providers/auth_repository_provider.dart';
import '../../domain/repository/auth_repository.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
      final repo = ref.read(authRepositoryProvider);

      return AuthController(repo);
    });

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository repository;

  AuthController(this.repository) : super(const AsyncData(null));

  Future<void> initAuth() async {
    state = const AsyncLoading();

    try {
      final token = await repository.initAuth();

      await repository.savePreAuthToken(token);

      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}
