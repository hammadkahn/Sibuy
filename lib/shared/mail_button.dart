import 'package:flutter/material.dart';

class EmailButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double elevation;
  final double borderRadius;

  const EmailButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.elevation = 0.0,
      this.borderRadius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: elevation,
      fillColor: Color(0xFFFFFFFF),
      constraints: BoxConstraints(minHeight: 54, minWidth: 327),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Color(0xFF8E8EA9))),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 24, left: 16, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                  color: Color(0xFF8E8EA9),
                  fontSize: 16,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
