import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/pages/quizz/components/stop_quizz_dialog.dart';
import 'package:interro/widgets/action_button.dart';

AppBar playAppBar(
    {required String title,
    String? stringColor,
    required BuildContext context,
    required Function() onTap}) {
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
    elevation: 0,
    leading: Row(
      children: [
        const SizedBox(width: 10),
        ActionButton(
          onTap: () => stopQuizzDialog(context),
          icon: Icons.close,
        ),
      ],
    ),
    actions: [
      ActionButton(onTap: onTap, icon: Icons.share_outlined),
    ],
  );
}
