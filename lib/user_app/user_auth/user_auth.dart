import 'package:flutter/material.dart';
import 'package:gigi_app/shared/mail_button.dart';
import 'package:gigi_app/user_app/email_verification/email_ver.dart';

import '../../constant/size_constants.dart';
import '../../shared/custom_button.dart';
import '../create_acc/user_create_acc.dart';

class user_auth extends StatefulWidget {
  const user_auth({Key? key}) : super(key: key);
  static String routeName = "/auth";

  @override
  State<user_auth> createState() => _user_authState();
}

class _user_authState extends State<user_auth> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 24, left: 24, top: 84),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 56),
                child: Image.asset(
                  'assets/images/auth_pic.png',
                  height: MediaQuery.of(context).size.height * 100 / 812,
                  width: MediaQuery.of(context).size.width * 100 / 375,
                ),
              ),
              const Text(
                'Let’s Get Started 😁',
                style: TextStyle(
                    fontFamily: 'Dmsans',
                    fontSize: 26,
                    fontWeight: FontWeight.w500),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 14, bottom: 49),
                child: Text(
                    'Sign up or login into to have a full  digital \nexperience in our restaurant',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8E8EA9))),
              ),
              CustomButton(
                  text: 'Sign In',
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const Email_ver()));
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Row(children: const <Widget>[
                  Expanded(
                      child: Divider(
                          color: Color(0xFFDCDCE4),
                          thickness: 1,
                          endIndent: 14)),
                  Text(
                    "OR",
                    style: TextStyle(color: Color(0xffA5A5BA), fontSize: 16),
                  ),
                  Expanded(
                      child: Divider(
                    color: Color(0xFFDCDCE4),
                    thickness: 1,
                    indent: 14,
                  )),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: EmailButton(
                    text: 'Continue with Apple ID',
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Email_ver()));
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: EmailButton(
                    text: 'Continue with Gmail',
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Email_ver()));
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 54, top: 20),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const User_create_acc())),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8981AE)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
