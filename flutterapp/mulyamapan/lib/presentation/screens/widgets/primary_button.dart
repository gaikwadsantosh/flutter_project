import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mulyankan/core/ui.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final IconData? iconData;
  const PrimaryButton(
      {super.key, required this.text, this.onPressed, this.iconData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        onPressed: onPressed,
        color: AppColors.accent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData),
            Text(text),
          ],
        ),
      ),
    );
  }
}
