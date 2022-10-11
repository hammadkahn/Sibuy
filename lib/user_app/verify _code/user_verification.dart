import 'dart:async';

import 'package:flutter/material.dart';
import 'package:SiBuy/services/auth/authentication.dart';
import 'package:SiBuy/shared/custom_button.dart';
import 'package:SiBuy/user_app/email_verification/email_ver.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class User_Verification extends StatefulWidget {
  const User_Verification({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<User_Verification> createState() => _User_VerificationState();
}

class _User_VerificationState extends State<User_Verification> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";
  var isLoading = false;
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
          body: Padding(
            padding: const EdgeInsets.only(left: 24, right: 32, top: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          child: Image.asset('assets/images/arrow-left.png')),
                    ),
                    const Spacer(),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 42),
                  child: Text("Verify Code ⚡️",
                      style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff32324D))),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text("We just sent a 4-digit verification code to ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffADADB6))),
                ),
                Text(widget.email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Mulish-Bold',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4A4A6A))),
                const Text("Enter the code in the box below to continue.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffADADB6))),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 22),
                  child: PinCodeTextField(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    appContext: context,
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      borderWidth: 2,
                      shape: PinCodeFieldShape.box,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      fieldHeight: 54,
                      fieldWidth: 54,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.white,
                      activeColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      return true;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn’t receive a code?",
                        style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff8E8EA9))),
                    InkWell(
                      onTap: reSendVerificationCode,
                      child: const Text(
                        "Resend Code",
                        style: TextStyle(
                          fontFamily: 'Mulish-Bold',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffff6600),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      text: "Next",
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        verify().whenComplete(() {
                          if (msg == 'success') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const Email_ver()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(msg!),
                              ),
                            );
                            setState(() {
                              isLoading = false;
                            });
                          }
                        });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? msg;
  String? token;

  Future<void> verify() async {
    final result = await MerchantAuthServices().verifyAccount(
      email: widget.email,
      code: textEditingController.text,
    );

    if (result['message'] == 'success') {
      setState(() {
        msg = result['message'];
        token = result['data']['token'];
      });
    } else {
      setState(() {
        msg = result['error'];
      });
    }
  }

  Future<void> reSendVerificationCode() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Processing Data'),
      backgroundColor: Colors.green.shade300,
    ));

    //get response from ApiClient
    dynamic res = await MerchantAuthServices().reSendCode(email: widget.email);
    checkReSendResult(res);
  }

  void checkReSendResult(dynamic res) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    //if there is no error, get the user's accesstoken and pass it to HomeScreen
    if (res['message'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Message: code sent to ${widget.email}'),
        backgroundColor: Colors.red.shade300,
      ));
    } else {
      //if an error occurs, show snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Message: ${res['error']}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}
