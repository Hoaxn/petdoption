import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/config/constants/theme_constant.dart';
import 'package:pet_adoption_app/features/splash/presentation/viewmodel/splash_viewmodel.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    // Wait for 2 seconds and then navigate
    Future.delayed(
      const Duration(seconds: 2),
      () {
        ref.read(splashViewModelProvider.notifier).init(context);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/logo_transparent.png'),
                ),
                const Text(
                  'PetDoption',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                CircularProgressIndicator(
                  color: ThemeConstant.mainColor,
                  backgroundColor: ThemeConstant.secondaryColor,
                ),
                const SizedBox(height: 10),
                const Text('version : 1.0.0'),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 3.1,
            child: const Text(
              'Developed by: Avinav',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
