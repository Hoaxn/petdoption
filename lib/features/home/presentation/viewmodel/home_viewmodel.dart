import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/config/routers/app_route.dart';
import 'package:pet_adoption_app/core/shared_pref/user_shared_pref.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, bool>(
  (ref) => HomeViewModel(
    ref.read(userSharedPrefsProvider),
  ),
);

class HomeViewModel extends StateNotifier<bool> {
  final UserSharedPrefs _userSharedPrefs;

  HomeViewModel(this._userSharedPrefs) : super(false);

  void logout(BuildContext context) async {
    state = true;
    // showSnackBar(
    //   message: 'Logging out ....',
    //   context: context,
    //   color: Colors.green,
    // );

    await _userSharedPrefs.removeUserToken();

    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        state = false;
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.loginRoute,
          (route) => false,
        );
      },
    );
  }
}
