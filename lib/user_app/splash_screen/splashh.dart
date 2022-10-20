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

class _user_splashState extends State<user_splash>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    // navigate to next page after 5 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const User_onboard()));
    });
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 3),
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: new AnimatedBuilder(
        animation: animationController,
        child: new Container(
          height: 150.0,
          width: 150.0,
          child: new Image.asset('assets/images/gigi-logo.png'),
        ),
        builder: (BuildContext context, Widget? _widget) {
          return new Transform.rotate(
            angle: animationController.value * 6.3,
            child: _widget,
          );
        },
      ),
    );
  }
  // void initState() {
  //   super.initState();
  //   Timer(
  //       const Duration(seconds: 3),
  //       () => Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => User_onboard())));
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       //animation of logo turn around
  //       child: const RotationTransition(
  //         turns: AlwaysStoppedAnimation(3 / 12),
  //         child: Image(
  //           image: AssetImage('assets/images/gigi-logo.png'),
  //           height: 200,
  //           width: 200,
  //         ),
  //       ),
  //       // child: Image.asset(
  //       //   'assets/images/gigi-logo.png',
  //       //   width: 100,
  //       //   height: 100,
  //       // ),
  //     ),
  //   );
  // }
}
