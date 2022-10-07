import 'package:flutter/material.dart';
import 'package:gigi_app/screens/onboarding/onboard.dart';
import 'package:gigi_app/shared/custom_button.dart';
import 'package:gigi_app/user_app/splash_screen/splashh.dart';
import 'package:gigi_app/user_app/user_menu/user_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../screens/full_menu/bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    userType = prefs.getString('user_type');
    status = prefs.getString('status');
    userId = prefs.getInt('userId');
    debugPrint('user type: $status');
    debugPrint(prefs.getString('country'));
    debugPrint(token);
    debugPrint(email);
    debugPrint(userType);
    setState(() {
      isChecked = true;
    });
  }

  @override
  void initState() {
    checkLogIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isChecked == true
        ? email != null && token != null && status == 'Active'
            ? userType == '1'
                ? User_bar(
                    token: token!,
                  )
                : Bar(token: token!)
            : Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        const Text(
                          'Login As:',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins-Bold',
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                            text: "Merchant Account",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const onBoard(),
                                ),
                              );
                            }),
                        const SizedBox(height: 20),
                        CustomButton(
                            text: "User Account",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const user_splash(),
                                ),
                              );
                            }),
                        const Expanded(
                          child: SizedBox(
                            height: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
        : Center(child: SmoothIndicator(offset: 0.1, count: 5));
  }
}
