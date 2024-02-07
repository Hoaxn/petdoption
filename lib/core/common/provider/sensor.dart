import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordProvider {
  static final proximityValue = StateProvider.autoDispose((ref) {
    // log(ref);
    return ref;
  });

  static final showConfirmPassword = StateProvider.autoDispose((ref) {
    return false;
  });
}

class ProximityProvider extends StateNotifier<int> {
  ProximityProvider() : super(0);

  set setProximityValue(int val) {}
}
