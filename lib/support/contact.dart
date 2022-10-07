import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key, this.isFromBottomNav = false}) : super(key: key);
  final bool? isFromBottomNav;

  _launchCaller() async {
    const url = "tel:1234567";
    if (await canLaunchUrl(Uri(scheme: 'tel', path: '+98712212121212'))) {
      await launchUrl(Uri(scheme: 'tel', path: '+98712212121212'));
    } else {
      throw 'Could not launch $url';
    }
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
                backgroundColor: Colors.white,
                body: Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 32, top: 17),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              if (isFromBottomNav == false)
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
                              if (isFromBottomNav == false) const Spacer(),
                              const Text('Support',
                                  style: TextStyle(
                                      fontFamily: 'Mulish',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 42),
                            child: Text("Contact :",
                                style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff32324D))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: InkWell(
                              onTap: () => _launchCaller(),
                              child: const Text("+98712212121212",
                                  style: TextStyle(
                                      fontFamily: 'Mulish',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffADADB6))),
                            ),
                          )
                        ])))));
  }
}
