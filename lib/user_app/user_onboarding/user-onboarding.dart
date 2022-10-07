import 'package:flutter/material.dart';
import 'package:gigi_app/screens/onboarding/onboard.dart';
import 'package:gigi_app/user_app/user_auth/user_auth.dart';

import '../../shared/custom_button.dart';

class User_onboard extends StatelessWidget {
  const User_onboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset('assets/images/user-onboard.png'),
          const Text("Find 1000+ Offers at\n One Place",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Dmsans',
                  fontSize: 26,
                  fontWeight: FontWeight.w500)),
          const Padding(
            padding: EdgeInsets.only(top: 14),
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
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.only(top: 26, right: 24, left: 24, bottom: 4),
            child: CustomButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const user_auth()));
              },
              text: 'Get Started',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const onBoard()));
            },
            child: const Padding(
              padding: EdgeInsets.only(bottom: 38, top: 10),
              child: Text(
                'Are You a Buisness?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffff6600)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
