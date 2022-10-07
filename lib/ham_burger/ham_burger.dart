import 'package:flutter/material.dart';
import 'package:gigi_app/screens/authentication/auth.dart';

import 'package:gigi_app/support/support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth/authentication.dart';

class Ham_burger extends StatelessWidget {
  const Ham_burger({Key? key, required this.token}) : super(key: key);
  final String token;

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
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 51, right: 29, left: 29),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/kfc.png'),
                  const Padding(
                    padding: EdgeInsets.only(top: 13, bottom: 10),
                    child: Text('KFC',
                        style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff32324D))),
                  ),
                  const Text(
                      'California, US\n+12345678901234  |   g,mamed@mail.com',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffC5C5C5))),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(top: 22, bottom: 25),
                          child: Divider(
                            color: Color(0xFFE6E6E6),
                            thickness: 0.5,
                            // height: 214,
                            indent: 82,
                            endIndent: 79,
                          )),
                      const Text("Active Offers",
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff32324D))),
                      const Padding(
                        padding: EdgeInsets.only(top: 18, bottom: 18),
                        child: Divider(
                          color: Color(0xFFE6E6E6),
                          thickness: 0.5,
                          // height: 214,
                          indent: 82,
                          endIndent: 79,
                        ),
                      ),
                      const Text("My Branches",
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff32324D))),
                      const Padding(
                          padding: EdgeInsets.only(top: 18, bottom: 18),
                          child: Divider(
                            color: Color(0xFFE6E6E6),
                            thickness: 0.5,
                            // height: 214,
                            indent: 82,
                            endIndent: 79,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => Support(
                                    token: token,
                                  )));
                        },
                        child: const Text("Support",
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff32324D))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 200, bottom: 56),
                        child: GestureDetector(
                          onTap: () {
                            MerchantAuthServices().logOut(token).then((value) {
                              if (value == 'success') {
                                isLogOut();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const auth_page()),
                                    (route) => false);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value)));
                              }
                            });
                          },
                          child: const Text('Log out',
                              style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff9E9E9E))),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> isLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
