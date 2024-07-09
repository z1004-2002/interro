import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color? backgroundColor;

  const DefaultButton({
    super.key,
    required this.text,
    required this.press,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: backgroundColor ?? secondColor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
