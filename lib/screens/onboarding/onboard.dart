import 'package:flutter/material.dart';
import 'package:gigi_app/screens/authentication/auth.dart';
import 'package:gigi_app/screens/authentication/sign_up_screen.dart';
import 'package:gigi_app/screens/onboarding/onboard_carousel.dart';
import 'package:gigi_app/shared/custom_button.dart';

import '../../constant/size_constants.dart';

class onBoard extends StatelessWidget {
  const onBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: ListView(
          children: [
            const carousel(),
            const Padding(
              padding: EdgeInsets.only(
                top: 8,
                right: 24,
                left: 24,
              ),
              child: Text("Full contactless experience",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Dmsans',
                      fontSize: 26,
                      fontWeight: FontWeight.w500)),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, right: 24, left: 24),
              child: Text(
                'From ordering to paying, that’s all \n contactless',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8E8EA9)),
              ),
            ),
            // const Spacer(),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const auth_page()));
              },
              child: const Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8E8EA9)),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(right: 24, left: 24),
              child: CustomButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SignUpScreen()));
                },
                text: 'Get Started',
              ),
            ),
          ],
        ));
  }
}
