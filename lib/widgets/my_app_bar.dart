import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';

AppBar myAppBar(
    {required String title,
    String? stringColor,
    required bool implyLeading,
    required BuildContext context,
    List<Widget>? actions}) {
  return AppBar(
    surfaceTintColor: Colors.white,
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
        color: secondColor,
        fontSize: 18,
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: implyLeading == true
        ? Transform.scale(
            scale: 0.7,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_backspace_rounded,
                size: 33,
                color: primaryColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          )
        : const SizedBox(),
    actions: actions,
  );
}
