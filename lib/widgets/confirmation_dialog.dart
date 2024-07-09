import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final dynamic content;
  final String? cancelText;
  final String? confirmText;
  final Function()? onPressed;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancelText,
    this.confirmText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(title),
      content: content is String ? Text(content) : content as Widget,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(cancelText ?? 'Annuler'),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(confirmText ?? 'Confirmer'),
        ),
      ],
    );
  }
}
