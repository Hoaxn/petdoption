// // Create a provider to check for internet connectivity using connectivity_plus

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

// final connectivityStatusProvider =
//     StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
//   (ref) => ConnectivityStatusNotifier(),
// );

// class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
//   ConnectivityStatusNotifier() : super(ConnectivityStatus.notDetermined) {
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       final newState = _getConnectivityStatus(result);
//       if (newState != state) {
//         state = newState;
//       }
//     });
//   }

//   ConnectivityStatus _getConnectivityStatus(ConnectivityResult result) {
//     if (result == ConnectivityResult.wifi ||
//         result == ConnectivityResult.mobile) {
//       return ConnectivityStatus.isConnected;
//     } else {
//       return ConnectivityStatus.isDisconnected;
//     }
//   }
// }

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivity {
  final Connectivity _connectivity;

  InternetConnectivity() : _connectivity = Connectivity();

  Future<bool> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
