import 'package:connectivity_monitor_plus/src/utils/connectivity_monitor.dart';
import 'package:flutter/material.dart';

class DialogUi extends StatelessWidget {
  final ConnectivityMonitor connectivityMonitor;

  const DialogUi({super.key, required this.connectivityMonitor});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: PopScope(
          canPop: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 60,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                "No Internet Connection",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Please check your connection and try again.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    if (connectivityMonitor.isLoading) {
                      return;
                    }
                    /*  if (!connectivityMonitor.hasInternet) {
                            KToast.showToast(
                                context, "Please enable internet connection");
                            return;
                          }*/
                    connectivityMonitor.isLoading = true;
                    connectivityMonitor.isInternetWorking().then((check) {
                      connectivityMonitor.isLoading = false;
                      if (!context.mounted) return;
                      if (check) {
                        Navigator.pop(context);
                      } else {
                        const snackBar = SnackBar(
                          content: Text("Please enable internet connection"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  },
                  child: connectivityMonitor.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          "Try Again",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
