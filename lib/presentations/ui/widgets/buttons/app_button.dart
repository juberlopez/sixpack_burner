

import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color ?color;
  final Color ?textColor;
  final EdgeInsets? padding;
  final bool enabled;
  final TextAlign textAlign;

  const AppButton(
      {Key ?key,
      required this.label,
      required this.onPressed,
      this.color = null,
      this.textColor = Colors.white,
      this.padding,
      this.enabled = true,
      this.textAlign = TextAlign.center
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: enabled ? onPressed : null,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                 stops: [
                0.0,
                1,
              ],
                colors: color == null
                    ? AppTheme.secondarylinearGradiant
                    : [
                        color!,
                        color!,
                      ],
              ),
              borderRadius: BorderRadius.circular(8.0)),
          child: Container(
            //constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
                  label,
                  textAlign: textAlign,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Quicksand',
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
