import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool showBorder;
  final AlignmentGeometry alignment;
  final double? fontSize;

  const LinkButton({
    super.key,
    required this.text,
    this.onPressed,
    this.showBorder = false,
    this.alignment = Alignment.topLeft,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      borderRadius: showBorder ? BorderRadius.circular(10.0) : null,
      child: Container(
        alignment: alignment,
        padding: EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          border: showBorder
              ? Border.all(
                  color: Colors.blue.shade900, // Set the border color
                  width: 1.0, // Set the border width
                )
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.blue.shade900, fontSize: fontSize),
        ),
      ),
    );
  }
}
