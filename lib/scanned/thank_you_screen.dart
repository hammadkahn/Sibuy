// ignore_for_file: prefer_const_constructors
import '../../constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/screens/full_menu/bar.dart';
import 'package:SiBuy/shared/custom_button.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = AppColors.APP_PRIMARY_COLOR;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 170,
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: themeColor,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/images/card.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              Text(
                "Thank You!",
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Payment done Successfully",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                "Click here to return to home page",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: screenHeight * 0.06),
              Flexible(
                child: CustomButton(
                  text: 'Home',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (ctx) => Bar(token: widget.token)),
                        (route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
