import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class categ extends StatelessWidget {
  categ({Key? key}) : super(key: key);
  //list of images
  List a = [Image.asset('assets/images/bev.png')];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: a.length,
      itemBuilder: (context, index) {
    return Container(
      child: a[index],
    );
      },
    );
  }
}
