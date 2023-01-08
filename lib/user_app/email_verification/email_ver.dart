import 'package:SiBuy/constant/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/user_app/user_menu/user_menu.dart';
import 'package:SiBuy/user_app/verify%20_code/user_verification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/color_constant.dart';
import '../../constant/size_constants.dart';
import '../../services/auth/authentication.dart';
import '../../shared/custom_button.dart';

class Email_ver extends StatefulWidget {
  const Email_ver({Key? key}) : super(key: key);
  static String routeName = "/auth";

  @override
  State<Email_ver> createState() => _Email_verState();
}

class _Email_verState extends State<Email_ver> {
  final _formKey = GlobalKey<FormState>();
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  var isLoading = false;
  var isLoggedIn = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(right: 24, left: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login to view deals! 📨',
                style: TextStyle(
                    fontFamily: 'Dmsans',
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 30 / 812,
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
                    return 'Please enter your email';
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
                      borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Password',
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 121),
                child: CustomButton(
                    isLoading: isLoading,
                    text: 'Sign In',
                    onPressed: loginUsers),
              ),
              InkWell(
                onTap: showsimple,
                child: const Text(
                  'Forgot Your Password?',
                  style: TextStyle(color: AppColors.APP_PRIMARY_COLOR),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? msg;
  String? token;

  Future<void> loginUsers() async {
    try {
      if (_formKey.currentState!.validate()) {
        UiUtils.disableKeyboard(context);
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
    if (res['message'] == 'success' && res['data']['type'] == 1) {
      String accessToken = res['data']['token'];
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => UserBottomBar(token: accessToken)),
          (route) => false);
    } else {
      prefs.clear();
      //if an error occurs, show snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Message: ${res['error'] ?? 'you can\'t sign-in as a user by entering merchant credientials'}}'),
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
