import 'dart:async';
import 'package:SiBuy/user_app/user_auth/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../../screens/authentication/auth.dart';
import '../../screens/full_menu/bar.dart';
import '../../services/auth/authentication.dart';
import '../../services/get_profile/get_user_info.dart';
import '../user_menu/user_menu.dart';

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
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    checkLogIn().whenComplete(() {
      Timer(const Duration(seconds: 3), () {
        email == null || token == null
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const user_auth()))
            : userType == '2'
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Bar(
                        token: token!,
                      ),
                    ),
                  )
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => User_bar(
                        token: token!,
                      ),
                    ),
                  );
      });

      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  String? token;
  String? email;
  String? userType;
  String? status;
  int? userId;

  var isChecked = false;
  Future<void> checkLogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
    email = prefs.getString('email');
    userType = prefs.getString('user_type') ?? '';
    status = prefs.getString('status');
    userId = prefs.getInt('userId');
    debugPrint('user type: $status');

    if(token != null){
      UserProfileModel user = await UserInformation().getUserProfile(token!);
      print(user);

      if(user.data == null){
        isLogOut();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => const user_auth()),
                (route) => false);
        return;
      }
    }

    debugPrint(token);
    debugPrint(email);
    debugPrint(userType.toString());
    setState(() {
      isChecked = true;
    });
  }

  Future<void> isLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: AnimatedBuilder(
        animation: animationController,
        child: SizedBox(
          height: 150.0,
          width: 150.0,
          child: Image.asset('assets/images/gigi-logo.png'),
        ),
        builder: (BuildContext context, Widget? widget) {
          return Transform.rotate(
            angle: animationController.value * 6.3,
            child: widget,
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
