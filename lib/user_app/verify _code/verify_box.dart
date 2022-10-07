import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Verify_box extends StatelessWidget {
  const Verify_box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '-',
          hintStyle: TextStyle(
              fontFamily: 'Mulish',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xffADADB6)),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
