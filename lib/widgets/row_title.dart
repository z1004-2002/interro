import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';

class RowTitle extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Function()? onTap;

  const RowTitle({
    super.key,
    required this.title,
    this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: secondColor,
            ),
            textAlign: TextAlign.end,
            softWrap: true,
          ),
        ),
        Flexible(
          child: Text(
            subTitle ?? '',
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.start,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
