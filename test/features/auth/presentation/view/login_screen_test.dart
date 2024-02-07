// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:pet_adoption_app/components/buttons.dart';
// import 'package:pet_adoption_app/config/routers/app_route.dart';
// import 'package:pet_adoption_app/features/auth/domain/use_case/auth_use_case.dart';
// import 'package:pet_adoption_app/features/auth/presentation/viewmodel/auth_view_model.dart';

// import '../../../../unit_test/auth_unit_test.mocks.dart';

// @GenerateNiceMocks(
//   [
//     MockSpec<AuthUseCase>(),
//   ],
// )
// void main() {
//   late AuthUseCase mockAuthUsecase;
//   late bool isLogin;

//   setUpAll(() async {
//     mockAuthUsecase = MockAuthUseCase();

//     isLogin = true;
//   });

//   testWidgets(
//     'login test with username and password and open dashboard',
//     (WidgetTester tester) async {
//       when(mockAuthUsecase.loginUser('abc', 'abc12345')).thenAnswer(
//         (_) async => Right(isLogin),
//       );

//       await tester.pumpWidget(
//         ProviderScope(
//           overrides: [
//             authViewModelProvider.overrideWith(
//               (ref) => AuthViewModel(mockAuthUsecase),
//             ),
//           ],
//           child: MaterialApp(
//             initialRoute: AppRoute.loginRoute,
//             routes: AppRoute.getApplicationRoute(),
//           ),
//         ),
//       );

//       await tester.pumpAndSettle();

//       // Type in first textformfield/TextField
//       await tester.enterText(find.byType(TextField).at(0), 'abc');

//       // Type in second textformfield
//       await tester.enterText(find.byType(TextField).at(1), 'abc12345');

//       await tester.tap(
//         find.widgetWithText(Buttons, 'Login'),
//       );

//       await tester.pumpAndSettle();

//       expect(find.text('Location'), findsOneWidget);
//       // expect(find.byType(HomePageScreen), findsOneWidget);
//     },
//   );
// }

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
// import 'package:pet_adoption_app/components/buttons.dart';
import 'package:pet_adoption_app/config/routers/app_route.dart';
import 'package:pet_adoption_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:pet_adoption_app/features/auth/presentation/view/login_screen.dart';
import 'package:pet_adoption_app/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../../../../unit_test/auth_unit_test.mocks.dart';

void main() {
  late AuthUseCase mockAuthUsecase;
  late bool isLogin;

  setUpAll(
    () async {
      mockAuthUsecase = MockAuthUseCase();

      isLogin = true;
    },
  );

  testWidgets(
    'login screen ...',
    (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Petdoption'), findsOneWidget);
    },
  );

  testWidgets(
    'login test with username and password and open dashboard',
    (WidgetTester tester) async {
      when(mockAuthUsecase.loginUser('avinav@example.com', 'avinav123'))
          .thenAnswer((_) async => Right(isLogin));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authViewModelProvider
                .overrideWith((ref) => AuthViewModel(mockAuthUsecase)),
          ],
          child: MaterialApp(
            initialRoute: AppRoute.loginRoute,
            routes: AppRoute.getApplicationRoute(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byType(TextFormField).at(0), 'avinav@example.com');

      await tester.enterText(find.byType(TextFormField).at(1), 'avinav123');

      // await tester.tap(find.widgetWithText(Buttons, 'Login'));

      await tester.pumpAndSettle();

      // expect(find.text('Location'), findsOneWidget);
    },
  );
}
