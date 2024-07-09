import 'package:flutter/material.dart';
import 'package:flutter_snackbar_plus/flutter_snackbar_plus.dart';

/// affiche une notification flash (toast) sur l'écran
void showSnackBar(
  BuildContext context,
  String message, {
  FlutterSnackBarLocation? location,
}) {
  FlutterSnackBar.showTemplated(
    context,
    title: message,
    configuration: FlutterSnackBarConfiguration(
      location: location ?? FlutterSnackBarLocation.top,
    ),
    style: const FlutterSnackBarStyle(
      backgroundColor: Colors.white,
      titleStyle: TextStyle(color: Colors.black),
    ),
  );
}
