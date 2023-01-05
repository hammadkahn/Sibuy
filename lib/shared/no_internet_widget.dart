import 'package:flutter/material.dart';
import '../../constant/color_constant.dart';

class NoInternetWidget extends StatelessWidget {
  NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Text('No Internet Available'),
      ),
    );
  }
}
