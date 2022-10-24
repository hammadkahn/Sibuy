import 'package:flutter/material.dart';
import 'package:SiBuy/screens/authentication/sign_up_screen.dart';

import 'package:SiBuy/shared/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/size_constants.dart';
import '../../services/auth/authentication.dart';
import '../../user_app/verify _code/user_verification.dart';
import '../full_menu/bar.dart';

class auth_page extends StatefulWidget {
  const auth_page({Key? key}) : super(key: key);
  static String routeName = "/auth";

  @override
  State<auth_page> createState() => _auth_pageState();
}

class _auth_pageState extends State<auth_page> {
  final _formKey = GlobalKey<FormState>();
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  var isLoading = false;
  var isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(right: 24, left: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 56),
                    child: Image.asset(
                      'assets/images/auth_pic.png',
                      height: MediaQuery.of(context).size.height * 67 / 812,
                      width: MediaQuery.of(context).size.width * 67 / 375,
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
                  TextFormField(
                    controller: emailCtr,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Email or Phone Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email or phone';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22, bottom: 26),
                    child: TextFormField(
                      controller: passwordCtr,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFEAEAEF)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Password',
                        // suffix: Icon(Icons.visibility)
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: CustomButton(
                        isLoading: isLoading,
                        text: 'Sign In',
                        onPressed: loginUsers),
                  ),
                  InkWell(
                    onTap: showsimple,
                    child: const Text(
                      'Forgot Your Password?',
                      style: TextStyle(color: Color(0xffff6600)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SignUpScreen()));
                    },
                    child: const Text(
                      'Registered as a Merchant',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8981AE)),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUsers() async {
    try {
      if (_formKey.currentState!.validate()) {
        //show snackbar to indicate loading
        setState(() {
          isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Processing Data'),
          backgroundColor: Colors.green.shade300,
        ));
        final prefs = await SharedPreferences.getInstance();
        //get response from ApiClient
        dynamic res =
            await MerchantAuthServices().login(emailCtr.text, passwordCtr.text);
        checkLoginResult(res, prefs);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void checkLoginResult(dynamic res, SharedPreferences prefs) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    //if there is no error, get the user's accesstoken and pass it to HomeScreen
    if (res['message'] == 'success' && res['data']['type'] == 2) {
      String accessToken = res['data']['token'];

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Bar(token: accessToken)),
          (route) => false);
    } else {
      //if an error occurs, show snackbar with error message
      prefs.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Message: ${res['error'] ?? 'you can\'t sign-in as a merchant by entering user credientials'}'),
        backgroundColor: Colors.red.shade300,
        action: SnackBarAction(
          label: res['error'] ==
                  'Your account is not verified. Please verify your account'
              ? 'Verify'
              : 'Close',
          onPressed: res['error'] ==
                  'Your account is not verified. Please verify your account'
              ? () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              User_Verification(email: emailCtr.text)));
                }
              : () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
        ),
      ));
    }
  }

  void showsimple() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Recover Password'),
          content: TextFormField(
            controller: emailCtr,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                borderRadius: BorderRadius.circular(16),
              ),
              hintText: 'Email or Phone Number',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Reset Password'),
              onPressed: () {
                MerchantAuthServices()
                    .resetPassword(emailCtr.text)
                    .then((value) => ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(value))))
                    .whenComplete(() {
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
