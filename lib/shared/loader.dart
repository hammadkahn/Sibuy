import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  Color? color;
  Loader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: CircularProgressIndicator(color: color??Color(0xFFff6600)),
      ),
    );
  }
}
