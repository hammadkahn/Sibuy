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
                    Container(
                      margin: const EdgeInsets.all(12),
                      //decoration
                      decoration: BoxDecoration(
                        color: const Color(0xffff66000),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          updatePassword().whenComplete(() {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(message)));
                          });
                        },
                        title: const Text(
                          'Change Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }

  String message = '';

  Future<void> updatePassword() async {
    if (_formKey.currentState!.validate()) {
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
          message = result;
        });
      } else {
        debugPrint('cant change password');
      }
    }
  }
}
