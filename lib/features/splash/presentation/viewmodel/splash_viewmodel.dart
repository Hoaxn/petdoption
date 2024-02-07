import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pet_adoption_app/config/routers/app_route.dart';
import 'package:pet_adoption_app/core/shared_pref/user_shared_pref.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<void> {
  final UserSharedPrefs _userSharedPrefs;
  SplashViewModel(this._userSharedPrefs) : super(null);

  init(BuildContext context) async {
    final data = await _userSharedPrefs.getUserToken();

    data.fold(
      (failure) {
        print("Error: ${failure.error}");
        // Navigate to the login screen as the token is not available.
        Navigator.popAndPushNamed(context, AppRoute.loginRoute);
      },
      (token) {
        if (token != null) {
          bool isTokenExpired = isValidToken(token);
          if (isTokenExpired) {
            Navigator.popAndPushNamed(context, AppRoute.loginRoute);
          } else {
            Navigator.popAndPushNamed(context, AppRoute.homeRoute);
          }
        } else {
          Navigator.popAndPushNamed(context, AppRoute.loginRoute);
        }
      },
    );
  }

  bool isValidToken(String? token) {
    if (token == null) {
      // If the token is null, it is considered expired.
      return true;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    int? expirationTimestamp = decodedToken['exp'] as int?;
    final currentDate = DateTime.now().millisecondsSinceEpoch;

    // If current date is greater than expiration timestamp, the token is expired.
    return expirationTimestamp != null &&
        currentDate > expirationTimestamp * 1000;
  }
}
