import 'package:flutter/material.dart';
import '../../constant/color_constant.dart';

class Loader extends StatelessWidget {
  Color? color;
  bool allowPadding;
  Loader({Key? key, this.color, this.allowPadding = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: allowPadding ? const EdgeInsets.all(10.0) : const EdgeInsets.all(0.0),
      child: Center(
        child: CircularProgressIndicator(color: color??AppColors.APP_PRIMARY_COLOR),
      ),
    );
  }
}
