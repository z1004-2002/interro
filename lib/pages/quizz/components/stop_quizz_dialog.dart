import 'package:flutter/material.dart';
import 'package:interro/pages/bottom_nav/bottom_nav.dart';
import 'package:interro/widgets/confirmation_dialog.dart';

void stopQuizzDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => ConfirmationDialog(
      title: "Abandonner le quizz",
      content: "Êtes-vous sûr de mettre fin au quizz ?",
      confirmText: "Abandonner",
      cancelText: "Continuer",
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const BottomNav(),
        ),
      ),
    ),
  );
}
