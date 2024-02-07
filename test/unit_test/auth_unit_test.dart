import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:pet_adoption_app/features/auth/presentation/viewmodel/auth_view_model.dart';

import 'auth_unit_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<AuthUseCase>(),
    MockSpec<BuildContext>(),
  ],
)
void main() {
  late AuthUseCase mockAuthUseCase;
  late ProviderContainer container;
  late BuildContext context;

  setUpAll(
    () {
      mockAuthUseCase = MockAuthUseCase();
      context = MockBuildContext();
      container = ProviderContainer(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUseCase),
          )
        ],
      );
    },
  );

  test(
    'check for the initial state',
    () async {
      final authState = container.read(authViewModelProvider);
      expect(authState.isLoading, false);
    },
  );

  test(
    'login test with valid username and password',
    () async {
      when(
        mockAuthUseCase.loginUser('abc', 'abc12345'),
      ).thenAnswer(
        (_) => Future.value(
          const Right(true),
        ),
      );

      await container
          .read(authViewModelProvider.notifier)
          .loginUser(context, 'abc', 'abc12345');

      final authState = container.read(authViewModelProvider);

      expect(authState.error, isNull);
    },
  );

  test(
    'login test with valid username and password',
    () async {
      when(
        mockAuthUseCase.loginUser('abc@example.com', 'abc12345'),
      ).thenAnswer(
        (_) => Future.value(
          Left(
            Failure(error: 'Invalid'),
          ),
        ),
      );

      await container
          .read(authViewModelProvider.notifier)
          .loginUser(context, 'abc@example.com', 'abc12345');

      final authState = container.read(authViewModelProvider);

      expect(authState.error, 'Invalid');
    },
  );

  tearDownAll(
    () {
      container.dispose();
    },
  );
}

// dart run build_runner build --delete-conflicting-outputs