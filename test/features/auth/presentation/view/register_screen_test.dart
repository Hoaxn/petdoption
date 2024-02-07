import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// import 'package:pet_adoption_app/components/buttons.dart';
import 'package:pet_adoption_app/config/routers/app_route.dart';
import 'package:pet_adoption_app/features/auth/domain/entity/user_entity.dart';
import 'package:pet_adoption_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:pet_adoption_app/features/auth/presentation/view/register_screen.dart';
import 'package:pet_adoption_app/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../../../../unit_test/auth_unit_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<AuthUseCase>(),
  ],
)
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;

  late UserEntity authEntity;

  setUpAll(
    () async {
      mockAuthUsecase = MockAuthUseCase();

      authEntity = const UserEntity(
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '1234567890',
        email: 'abcd@example.com',
        password: '12345678',
        city: 'Kathmandu',
        country: 'Nepal',
      );
    },
  );

  testWidgets(
    'register screen ...',
    (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RegisterScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Register Here'), findsOneWidget);
    },
  );

  testWidgets(
    'register screen',
    (tester) async {
      when(
        mockAuthUsecase.registerUser(authEntity),
      ).thenAnswer(
        (_) async => const Right(true),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authViewModelProvider.overrideWith(
              (ref) => AuthViewModel(mockAuthUsecase),
            ),
          ],
          child: MaterialApp(
            initialRoute: AppRoute.registerRoute,
            routes: AppRoute.getApplicationRoute(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'John');

      await tester.enterText(find.byType(TextFormField).at(1), 'Doe');

      await tester.enterText(find.byType(TextFormField).at(2), '1234567890');

      await tester.enterText(
          find.byType(TextFormField).at(3), 'abcd@example.com');

      await tester.enterText(find.byType(TextFormField).at(4), '12345678');

      await tester.pumpAndSettle();

      //=========================== Find the register button===========================
      // final registerButtonFinder = find.widgetWithText(Buttons, 'Register');

      // await tester.tap(registerButtonFinder);

      await tester.pumpAndSettle();
    },
  );
}
