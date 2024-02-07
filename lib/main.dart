import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/core/app.dart';
import 'package:pet_adoption_app/core/network/local/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // );
  await HiveService().init();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
