import 'package:flutter/material.dart';
import 'package:SiBuy/shared/mail_button.dart';
import 'package:SiBuy/user_app/email_verification/email_ver.dart';
import '../../constant/app_styles.dart';
import '../../constant/color_constant.dart';
import '../../constant/size_constants.dart';
import '../../screens/authentication/auth.dart';
import '../../screens/authentication/sign_up_screen.dart';
import '../../shared/custom_button.dart';
import '../../shared/no_internet_widget.dart';
import '../create_acc/user_create_acc.dart';
import '../user_menu/full_user_meu.dart';
import '../user_menu/user_menu.dart';

class user_auth extends StatefulWidget {
  const user_auth({Key? key}) : super(key: key);
  static String routeName = "/auth";

  @override
  State<user_auth> createState() => _user_authState();
}

class _user_authState extends State<user_auth> {

  bool isInternetAvailable = true;

  @override
  void initState() {
    // TODO: implement initState
    UiUtils.checkInternet().then((value){
      isInternetAvailable = value;
      setState(() { });
    });
    super.initState();
  }

  int _value = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 24, left: 24, top: 84),
        child: !isInternetAvailable ? NoInternetWidget() : SingleChildScrollView(
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
                'Let’s get you started!',
                style: TextStyle(
                    fontFamily: 'Dmsans',
                    fontSize: 26,
                    fontWeight: FontWeight.w500),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 14, bottom: 49),
                child: Text('A world of discounts is waiting for you!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8E8EA9))),
              ),
              CustomButton(
                  text: 'Sign In As User',
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const Email_ver()));
                  }),
              Insets.gapH10,
              CustomButton(
                  text: "Sign In As Merchant",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const auth_page(),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Row(children: const <Widget>[
                  Expanded(
                      child: Divider(
                          color: Color(0xFFDCDCE4),
                          thickness: 1,
                          endIndent: 14)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const User_create_acc())),
                  child: const SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const UserBottomBar(token: '',)),
                          (route) => false);
                },
                child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      'Explore As Guest',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height  * 0.005,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SignUpScreen()));
                },
                child: const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      'Registered as a Merchant',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _value = 0),
                    child: Container(
                      height: 56,
                      width: 56,
                      color: _value == 0
                          ? AppColors.APP_PRIMARY_COLOR
                          : Colors.transparent,
                      child: Image.asset(
                        'assets/images/com.png',
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => setState(() => _value = 1),
                    child: Container(
                      height: 56,
                      width: 56,
                      color: _value == 1
                          ? AppColors.APP_PRIMARY_COLOR
                          : Colors.transparent,
                      child: Image.asset(
                        'assets/images/uk.png',
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => setState(() => _value = 2),
                    child: Container(
                      height: 56,
                      width: 56,
                      color: _value == 2
                          ? AppColors.APP_PRIMARY_COLOR
                          : Colors.transparent,
                      child: Image.asset(
                        'assets/images/china.png',
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
