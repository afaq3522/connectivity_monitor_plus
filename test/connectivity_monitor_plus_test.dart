import 'package:connectivity_monitor_plus/src/mock/mock_connectivity_manager.dart';
import 'package:connectivity_monitor_plus/src/utils/connectivity_monitor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // ✅ Add this line
  test('check connectivity', () async {
    final connectivityMonitor = ConnectivityMonitor(MockConnectivityManager());
    await Future.delayed(Duration(seconds: 2));
    expect(connectivityMonitor.hasInternet, true);
    expect(await connectivityMonitor.isInternetWorking(isMock: true), true);
  });
}
