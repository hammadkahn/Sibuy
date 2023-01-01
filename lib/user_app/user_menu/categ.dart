import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class categ extends StatelessWidget {
  categ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [
            Container(
                //1
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                    color: Color(0xffF4F5F9), shape: BoxShape.circle),
                child: Image.asset('assets/images/car_acc.png')),
            const Text("Car Accessories",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins-Medium',
                    color: Color(0xFF868889))),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 21),
          child: Column(
            children: [
              Container(
                //1
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                    color: Color(0xffF4F5F9), shape: BoxShape.circle),
                child: Image.asset('assets/images/autom.png'),
              ),
              const Text("Automotive",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins-Medium',
                      color: Color(0xFF868889))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 21),
          child: Column(
            children: [
              Container(
                //1
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                    color: const Color(0xffF4F5F9), shape: BoxShape.circle),
                child: Image.asset('assets/images/car_be.png'),
              ),
              Text("Car beauty",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins-Medium',
                      color: Color(0xFF868889))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 21),
          child: Column(
            children: [
              Container(
                //1
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                    color: const Color(0xffF4F5F9), shape: BoxShape.circle),
                child: Image.asset('assets/images/Cinema.png'),
              ),
              Text("Cinema",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins-Medium',
                      color: Color(0xFF868889))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 21),
          child: Column(
            children: [
              Container(
                //1
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                    color: const Color(0xffF4F5F9), shape: BoxShape.circle),
                child: Image.asset('assets/images/ent.png'),
              ),
              Text("Entertainment",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins-Medium',
                      color: Color(0xFF868889))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 21),
          child: Column(
            children: [
              Container(
                //1
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                    color: const Color(0xffF4F5F9), shape: BoxShape.circle),
                child: Image.asset('assets/images/TV.png'),
              ),
              Text("TV",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins-Medium',
                      color: Color(0xFF868889))),
            ],
          ),
        ),
      ]),
    );
  }
}
