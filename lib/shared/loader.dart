import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  Color? color;
  Loader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color??Color(0xFFff6600)),
    );
  }
}
