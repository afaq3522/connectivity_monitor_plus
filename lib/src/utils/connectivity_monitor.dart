import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class ConnectivityMonitor with ChangeNotifier {
  bool _hasInternet = true;
  bool get hasInternet => _hasInternet;

  bool isLoading = false;


  final _connectivityManager = Connectivity();

  ConnectivityMonitor() {
    _checkInternet();
    _listenInternet();
  }

  void _checkInternet() {
    _connectivityManager.checkConnectivity().then(_internetResult);
  }

  void _listenInternet() {
    _connectivityManager.onConnectivityChanged.listen(_internetResult);
  }

  void _internetResult(List<ConnectivityResult> result) async {
    if (result.first == ConnectivityResult.none) {
      _hasInternet = false;
    } else {
      final isActualInternetWorking = await isInternetWorking();
      _hasInternet = isActualInternetWorking;
    }
    notifyListeners();
  }

  Future<bool> isInternetWorking() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 10));

      return response.statusCode == 200; // Internet is working
    } catch (_) {
      return false; // No actual internet
    }
  }
}
