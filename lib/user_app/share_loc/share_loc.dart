import 'package:flutter/material.dart';
import 'package:gigi_app/shared/custom_button.dart';
import 'package:gigi_app/user_app/current_loc/current_loc.dart';

// ignore: camel_case_types
class Share_user_loc extends StatefulWidget {
  const Share_user_loc({Key? key}) : super(key: key);

  @override
  State<Share_user_loc> createState() => _Share_user_locState();
}

// ignore: camel_case_types
class _Share_user_locState extends State<Share_user_loc> {
  @override
  void initState() {
    super.initState();
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
                Padding(
                  padding: const EdgeInsets.only(top: 152),
                  child: Image.asset(
                    'assets/images/loc.png',
                    height: 70,
                    width: 70,
                  ),
                ),
                const Text("Share your location \n with us to order",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF32324D))),
                const Text(
                    "Please enter your location or allow access to your location to find all restaurants that \n are near you ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8E8EA9))),
                const Spacer(),
                CustomButton(
                    text: "Continue",
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const Current_user_loc()));
                    }),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
