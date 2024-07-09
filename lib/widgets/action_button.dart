import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';

/// bouton d'action dans le appBar
class ActionButton extends StatelessWidget {
  final Function() onTap;
  final IconData icon;

  const ActionButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Icon(
          icon,
          color: secondColor,
        ),
      ),
    );
  }
}
