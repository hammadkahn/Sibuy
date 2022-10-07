import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gigi_app/user_app/current_loc/loc_dropdown.dart';
import 'package:gigi_app/user_app/virtual_assistant/virtual_assistant.dart';

import '../../shared/custom_button.dart';

class Current_user_loc extends StatelessWidget {
  const Current_user_loc({Key? key}) : super(key: key);

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
                    padding:
                        const EdgeInsets.only(left: 24, right: 32, top: 17),
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
                                    child: Image.asset(
                                        'assets/images/arrow-left.png')),
                              ),
                              Spacer(),
                            ],
                          ),
                          Text(
                              "Share your location \n with us to get exciting offers",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF32324D))),
                          Text(
                              "Please enter your location or allow access to your location to find all restaurants that are near you ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF8E8EA9))),
                          loc_dropdown(),
                          Spacer(),
                          CustomButton(
                              text: "Continue",
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Virtual_user()));
                              }),
                          SizedBox(height: 25),
                        ])))));
  }
}
