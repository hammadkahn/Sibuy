import 'package:flutter/material.dart';
import 'package:gigi_app/chat/user_list_screen.dart';
import 'package:gigi_app/support/contact.dart';

class Support extends StatelessWidget {
  const Support({Key? key, required this.token}) : super(key: key);
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
                backgroundColor: Colors.white,
                body: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 32, top: 17),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            const Spacer(),
                            const Text('Support',
                                style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 42),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Contact()));
                            },
                            child: const Text("Contact Support",
                                style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff32324D))),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 18, bottom: 18),
                          child: Divider(
                            color: Color(0xFFE6E6E6),
                            thickness: 1,
                            // height: 214,
                            indent: 25,
                            endIndent: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserListScreen(
                                          token: token,
                                        )));
                          },
                          child: const Text("Chat Support",
                              style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff32324D))),
                        ),
                      ]),
                ))));
  }
}
