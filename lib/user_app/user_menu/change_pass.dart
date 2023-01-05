import 'package:SiBuy/constant/app_styles.dart';
import 'package:SiBuy/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../constant/color_constant.dart';
import '../../services/auth/authentication.dart';

class Change_pass extends StatefulWidget {
  const Change_pass({super.key, required this.token});
  final String token;

  @override
  State<Change_pass> createState() => _Change_passState();
}

class _Change_passState extends State<Change_pass> {
  final _formKey = GlobalKey<FormState>();
  final currentPassCtr = TextEditingController();
  final newPassCtr = TextEditingController();
  final confirmCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.APP_PRIMARY_COLOR,
          title: const Text('Change Password'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //three text feild for the changing password
                    TextFormField(
                      controller: currentPassCtr,
                      decoration: const InputDecoration(
                        labelText: 'Current Password',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: newPassCtr,
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: confirmCtr,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            newPassCtr.text != confirmCtr.text) {
                          return 'Passwod not matched';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //button for the changing password
                    CustomButton(
                      text: 'Change Password',
                      onPressed: () {
                        updatePassword().whenComplete(() {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(message)));
                        });
                      }
                    ),
                  ]),
            ),
          ),
        ));
  }

  String message = '';

  Future<void> updatePassword() async {
    if (_formKey.currentState!.validate()) {
      UiUtils.disableKeyboard(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Processing...')));
      final result = await MerchantAuthServices().changePassword(
        widget.token,
        currentPassCtr.text,
        newPassCtr.text,
        confirmCtr.text,
      );
      if (result.isNotEmpty) {
        setState(() {
          if(result == "success"){
            currentPassCtr.text = '';
            newPassCtr.text = '';
            confirmCtr.text = '';
            message = "Password Changed Successfully";
          }
          else{
            message = result;
          }
        });
      } else {
        debugPrint('cant change password');
      }
    }
  }
}
