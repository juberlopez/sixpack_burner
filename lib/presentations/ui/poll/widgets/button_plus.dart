import 'package:flutter/material.dart';

class ButtonPlus extends StatelessWidget {
  ButtonPlus({Key? key, required this.onPressed, required this.text})
      : super(key: key);
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      primary: Colors.white,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return BorderSide(
              color: Colors.white,
              width: 1,
            );
          return BorderSide(
              color: Colors.white, width: 1); // Defer to the widget's default.
        },
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 8),
      child: SizedBox(
        height: 45,
        child: OutlinedButton(
          style: outlineButtonStyle,
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}
