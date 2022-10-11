import 'package:flutter/material.dart';
import 'package:SiBuy/chat/user_list_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class support_user extends StatefulWidget {
  const support_user({Key? key, required this.phoneNumber, required this.token})
      : super(key: key);
  final String phoneNumber;
  final String token;

  @override
  State<support_user> createState() => _support_userState();
}

class _support_userState extends State<support_user> {
  // _launchCaller() async {
  //   if (await canLaunchUrl(
  //       Uri.parse('https://gigifrontend.zanforthstaging.com/userChat'))) {
  //     await launchUrl(
  //         Uri.parse('https://gigifrontend.zanforthstaging.com/userChat'));
  //   } else {
  //     throw 'Could not launch url';
  //   }
  // }

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
                            const SizedBox(width: 20),
                            const Text('Support',
                                style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 42),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => const Contact()));
                        //     },
                        //     child: const Text("Contact Support",
                        //         style: TextStyle(
                        //             fontFamily: 'Mulish',
                        //             fontSize: 12,
                        //             fontWeight: FontWeight.w600,
                        //             color: Color(0xff32324D))),
                        //   ),
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.only(top: 18, bottom: 18),
                        //   child: Divider(
                        //     color: Color(0xFFE6E6E6),
                        //     thickness: 1,
                        //     // height: 214,
                        //     indent: 25,
                        //     endIndent: 13,
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserListScreen(token: widget.token),
                              ),
                            );
                          },
                          child: const Text("Chat Support",
                              style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff32324D))),
                        )
                      ]),
                ))));
  }
}
