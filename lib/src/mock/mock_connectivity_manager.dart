import 'package:connectivity_plus/connectivity_plus.dart';

///mock class that can use to run test cases
///replace connectivity class in [connectivity_monitor.dart]
class MockConnectivityManager {

  ///check connectivity result
  Future<List<ConnectivityResult>> checkConnectivity() {
    return Future.value([ConnectivityResult.wifi]);
  }

  ///check stream status
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return Stream.empty();
  }
}
