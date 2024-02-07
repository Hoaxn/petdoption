import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pet_adoption_app/core/failure/failure.dart';
import 'package:pet_adoption_app/features/auth/domain/entity/user_entity.dart';
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
    'register test with valid fields',
    () async {
      const user = UserEntity(
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '1234567890',
        email: 'abcd@example.com',
        password: '12345678',
        city: 'Kathmandu',
        country: 'Nepal',
      );

      when(
        mockAuthUseCase.registerUser(user),
      ).thenAnswer(
        (_) => Future.value(
          const Right(true),
        ),
      );

      await container
          .read(authViewModelProvider.notifier)
          .registerUser(context, user);

      final authState = container.read(authViewModelProvider);

      expect(authState.error, isNull);
    },
  );

  test(
    'register test with valid fields',
    () async {
      const user = UserEntity(
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '1234567890',
        email: 'abcd@example.com',
        password: '12345678',
        city: 'Kathmandu',
        country: 'Nepal',
      );

      when(
        mockAuthUseCase.registerUser(user),
      ).thenAnswer(
        (_) => Future.value(
          Left(
            Failure(error: 'Invalid'),
          ),
        ),
      );

      await container
          .read(authViewModelProvider.notifier)
          .registerUser(context, user);

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
