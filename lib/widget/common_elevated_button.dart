import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  final String buttonLabel;
  final void Function() onButtonTap;
  final Color buttonColor;

  const CommonElevatedButton({
    super.key,
    required this.buttonLabel,
    required this.onButtonTap,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onButtonTap,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: buttonColor,
        ),
      ),
    );
  }
}
