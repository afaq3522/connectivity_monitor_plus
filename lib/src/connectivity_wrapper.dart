import 'package:connectivity_monitor_plus/src/dialog_ui.dart';
import 'package:connectivity_monitor_plus/src/utils/connectivity_monitor.dart';
import 'package:flutter/material.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;
  final Widget? dialogUi;

  const ConnectivityWrapper({
    super.key,
    required this.child,
    this.dialogUi,
  });

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  final connectivityMonitor = ConnectivityMonitor();
  bool isDialogShowing = false;

  void _update() => setState(() {});

  @override
  void initState() {
    connectivityMonitor.addListener(_update);
    super.initState();
  }

  @override
  void dispose() {
    connectivityMonitor.removeListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isDialogShowing || connectivityMonitor.hasInternet) {
        return;
      }
      isDialogShowing = true;
      showDialog(
        context: context,
        builder: (context) =>
            widget.dialogUi ??
            DialogUi(connectivityMonitor: connectivityMonitor),
      ).then((value) {
        isDialogShowing = false;
      });
    });
    return widget.child;
  }
}
