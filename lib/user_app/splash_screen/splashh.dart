import 'dart:async';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/User_APP/user_onboarding/user-onboarding.dart';

class user_splash extends StatefulWidget {
  const user_splash({Key? key}) : super(key: key);

  @override
  State<user_splash> createState() => _user_splashState();
}

class _user_splashState extends State<user_splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => User_onboard())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/gigi-logo.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
