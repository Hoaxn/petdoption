import 'dart:developer';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/config/routers/app_route.dart';
import 'package:pet_adoption_app/core/app.dart';
import 'package:pet_adoption_app/core/shared_pref/user_shared_pref.dart';

class SensorUtils {
  static void listen() {
    proximityEvents!.listen((ProximityEvent event) {
      if (event.proximity < 1) {
        logout();
        log("message");
      }
      // setState(() {
      //   // _proximityValue = event.proximity;
      //   log("------------${event.proximity}");
      // }
    });
  }

  static void accelerometer({Function()? fun}) {
    List<double> accelerometerValue = <double>[];

    accelerometerEvents!.listen((event) {
      accelerometerValue = <double>[event.x, event.y, event.z];

      final List<String> accelerometer =
          accelerometerValue.map((double v) => v.toStringAsFixed(1)).toList();
      final val = double.tryParse(accelerometer[0]) ?? 0;

      if (val.abs() > 10) {
        if (fun != null) fun();
        log("accelerometer value ${accelerometer[0]}");
      }
    });
  }

  static void logout() async {
    final result = await UserSharedPrefs().removeUserToken();
    result.fold(
      (failure) {
        // Handle the failure, e.g., display an error message
        print('Failed to remove token: ${failure.error}');
      },
      (success) {
        print('Token removed successfully');
        print(Nav_KEY.currentContext);
        if (Nav_KEY.currentContext != null) {
          Navigator.pushNamed(Nav_KEY.currentContext!, AppRoute.loginRoute);
        }
      },
    );
  }
}
