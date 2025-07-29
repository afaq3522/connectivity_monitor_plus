import 'package:connectivity_monitor_plus/src/dialog_ui.dart';
import 'package:connectivity_monitor_plus/src/utils/connectivity_monitor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// A widget that wraps its child and shows a dialog when there is no internet connectivity.
class ConnectivityWrapper extends StatefulWidget {
  /// The widget below this wrapper, shown when internet is available.
  final Widget child;

  /// A custom widget to display when there is no internet connection.
  /// If null, a default dialog will be shown.
  final Widget? dialogUi;

  ///if false it will not check actual internet connection
  ///just show popup on connection state change
  final bool checkActualInternet;

  /// Creates a [ConnectivityWrapper] that listens for connectivity changes.
  const ConnectivityWrapper({
    super.key,
    required this.child,
    this.dialogUi,
    this.checkActualInternet = true,
  });

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late ConnectivityMonitor connectivityMonitor;
  bool isDialogShowing = false;

  void _update() => setState(() {});

  @override
  void initState() {
    connectivityMonitor = ConnectivityMonitor(
      Connectivity(),
      checkActualInternet: widget.checkActualInternet,
    )..addListener(_update);
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
      //auto dispose dialog if internet is back
      if (isDialogShowing && connectivityMonitor.hasInternet) {
        Navigator.pop(context);
        return;
      }
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
