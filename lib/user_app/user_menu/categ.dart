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
                child: Image.asset('assets/images/veg.png')),
            const Text("Vegetables",
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
                child: Image.asset('assets/images/fruit.png'),
              ),
              const Text("Fruits",
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
                child: Image.asset('assets/images/bev.png'),
              ),
              Text("Beverages",
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
                child: Image.asset('assets/images/grocery.png'),
              ),
              Text("Grocery",
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
                child: Image.asset('assets/images/oil.png'),
              ),
              Text("Edible oil",
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
                child: Image.asset('assets/images/hold.png'),
              ),
              Text("Household",
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
