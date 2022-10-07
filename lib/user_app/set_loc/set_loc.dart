import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gigi_app/user_app/share_loc/share_loc.dart';

class Set_user_location extends StatefulWidget {
  const Set_user_location({Key? key}) : super(key: key);

  @override
  State<Set_user_location> createState() => _Set_user_locationState();
}

class _Set_user_locationState extends State<Set_user_location> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const Share_user_loc())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0xffFCFCFC),
            Color(0xffF7F7F7),
            Color(0xffF7F7F7),
            Color(0xffF7F7F7),
            Color(0xffFCFCFC)
          ])),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 24, right: 32, top: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
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
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset('assets/images/arrow-left.png')),
                    ),
                    const Spacer(),
                  ],
                ),
                const Text("Set your locations 📍",
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF32324D))),
                Container(
                  height: 212,
                  width: 327,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/loc.png',
                        height: 70,
                        width: 70,
                      ),
                      const Text("Select location manually",
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF212134))),
                      const Text(
                          "If you prefer to add your location manually,\n here is your option",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8E8EA9))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
