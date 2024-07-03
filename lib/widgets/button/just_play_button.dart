import 'package:flutter/material.dart';

class JustPlayButton extends StatelessWidget {
  const JustPlayButton({
    super.key,
    this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.height = 40,
  });
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.withOpacity(0.4);
          } else {
            return Colors.black;
          }
        }),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: onPressed == null ? Colors.grey : Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}
