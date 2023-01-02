import 'package:flutter/material.dart';

import '../constant/color_constant.dart';
import 'loader.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double elevation;
  final double borderRadius;
  final bool isLoading;
  final bool? padding;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.elevation = 0.0,
      this.borderRadius = 0,
      this.isLoading = false,
      this.padding = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: elevation,
      fillColor: AppColors.APP_PRIMARY_COLOR,
      constraints: BoxConstraints(
          minHeight: padding == true ? 25 : 54,
          minWidth: padding == true ? 150 : 327),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: padding == true
            ? const EdgeInsets.all(4)
            : const EdgeInsets.only(top: 16, bottom: 24, left: 16, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLoading == true
                ? Loader(color: Colors.white,)
                : Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Mulish',
                    ),
                    textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
  }
}
