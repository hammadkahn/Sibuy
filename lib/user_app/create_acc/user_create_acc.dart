import 'dart:developer';

import 'package:SiBuy/providers/deal_provider.dart';
import 'package:flutter/material.dart';

import 'package:SiBuy/services/auth/authentication.dart';
import 'package:SiBuy/shared/custom_button.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../verify _code/user_verification.dart';

class User_create_acc extends StatefulWidget {
  const User_create_acc({Key? key}) : super(key: key);

  @override
  State<User_create_acc> createState() => _User_create_accState();
}

class _User_create_accState extends State<User_create_acc> {
  final _key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final countryCtr = TextEditingController();
  final cityCtr = TextEditingController();
  final passCtr = TextEditingController();
  final dobCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final phoneNumberCtr = TextEditingController();
  final referralCodeCtr = TextEditingController();

  var isLoading = false;

  String? langDropdownvaluee = 'English';
  String genderDropdown = 'Male';
  String? cityCode;
  DealProvider? _provider;
  ValueNotifier<bool> isLoaded = ValueNotifier(false);

  var items = [
    'Male',
    'Female',
    'Other',
  ];
  String? selectedCountry;
  String? languageId;
  @override
  void initState() {
    _provider = Provider.of<DealProvider>(context, listen: false);
    debugPrint(countryCtr.text);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _provider!
        .getAllLanguages()
        .then((value) => _provider!.getAllCountries())
        .whenComplete(() {
      isLoaded.value = true;
      // setState(() {
      //   // items = Provider.of<DealProvider>(context, listen: false).languages;
      // });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.only(right: 24, left: 24, top: 116),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Getting started! ✌️',
                  style: TextStyle(
                      fontFamily: 'Dmsans',
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 14, bottom: 40),
                  child: Text(
                      'Look like you are new to us! To SiBuy365 Registration Form - Your Everyday Deal App.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8E8EA9))),
                ),
                TextFormField(
                  controller: nameCtr,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Fullname',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: TextFormField(
                    controller: emailCtr,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Please a vaild enter email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: TextFormField(
                    controller: phoneNumberCtr,
                    textInputAction: TextInputAction.next,
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton(
                    underline: Container(),
                    isExpanded: true,
                    // Initial Value
                    value: genderDropdown,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        genderDropdown = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: TextField(
                    controller: dobCtr,
                    textInputAction: TextInputAction.next,
                    readOnly: true,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.calendar_today_rounded),
                        labelText: 'Date of Birth',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFEAEAEF)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFEAEAEF)),
                          borderRadius: BorderRadius.circular(16),
                        )),
                    onTap: () async {
                      DateTime? pickdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2030));
                      if (pickdate != null) {
                        setState(() {
                          dobCtr.text =
                              DateFormat('dd-MM-yyyy').format(pickdate);
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 26, top: 16),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: passCtr,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Password',
                      // suffix: Icon(Icons.visibility)
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please a strong password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: passCtr,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: ' Confirm Password',
                      // suffix: Icon(Icons.visibility)
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please a strong password';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 8),

                //country dropdown
                ValueListenableBuilder(
                  valueListenable: isLoaded,
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: TextFormField(
                        onTap: () => value == false
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Loading...'),
                                ),
                              )
                            : showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.3,
                                  child: ListView.builder(
                                    itemCount:
                                        _provider!.allCountries.data!.length,
                                    itemBuilder: ((context, index) {
                                      return InkWell(
                                        onTap: () {
                                          selectedCountry = _provider!
                                              .allCountries.data![index].id
                                              .toString();
                                          countryCtr.text = _provider!
                                              .allCountries.data![index].name!;
                                          if (selectedCountry != null) {
                                            _provider!.getAllCities(_provider!
                                                .allCountries.data![index].id
                                                .toString());
                                          }

                                          log(selectedCountry!);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              15, 12, 15, 8),
                                          child: Text(_provider!
                                              .allCountries.data![index].name!),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                        textInputAction: TextInputAction.next,
                        controller: countryCtr,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Country',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFEAEAEF)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: countryCtr.text,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'country field is required';
                          }
                          return null;
                        },
                      ),
                    );
                  },
                ),

                //city dropdown
                Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: TextFormField(
                    onTap: () => selectedCountry == null ||
                            selectedCountry!.isEmpty
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select your country first'),
                            ),
                          )
                        : showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.3,
                                  child: ListView.builder(
                                    itemCount:
                                        _provider!.allCities.data!.length,
                                    itemBuilder: ((context, index) {
                                      return InkWell(
                                        onTap: () {
                                          cityCode = _provider!
                                              .allCities.data![index].id
                                              .toString();
                                          cityCtr.text = _provider!
                                              .allCities.data![index].name!;

                                          log(selectedCountry!);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              15, 12, 15, 8),
                                          child: Text(_provider!
                                              .allCities.data![index].name!),
                                        ),
                                      );
                                    }),
                                  ),
                                )),
                    readOnly: true,
                    controller: cityCtr,
                    decoration: InputDecoration(
                      labelText: 'City',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: cityCtr.text,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'city field required';
                      }
                      return null;
                    },
                  ),
                ),

                //reference code container
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Referral Code (Optional)',
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.maxFinite,
                  child: ValueListenableBuilder(
                    valueListenable: isLoaded,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return isLoaded.value == false
                          ? const CircularProgressIndicator()
                          : DropdownButton<String>(
                              isExpanded: true,
                              // Initial Value
                              value: langDropdownvaluee,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: _provider!.languages
                                  .map<DropdownMenuItem<String>>(
                                      (String items) {
                                return DropdownMenuItem<String>(
                                  value: items,
                                  child: Text(items),
                                  onTap: () {
                                    for (int i = 0;
                                        i <
                                            _provider!
                                                .languageData['data'].length;
                                        i++) {
                                      if (items ==
                                          _provider!.languageData['data'][i]
                                              ['name']) {
                                        languageId = _provider!
                                            .languageData['data'][i]['id']
                                            .toString();
                                        break;
                                      }
                                    }
                                    print(languageId);
                                  },
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  langDropdownvaluee = newValue!;
                                });
                              },
                            );
                    },
                  ),
                ),
                CustomButton(
                  isLoading: isLoading,
                  text: 'Next',
                  onPressed: _handleRegister,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      //show snackbar to indicate loading
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      //the user data to be sent
      Map<String, dynamic> userData = {
        'name': nameCtr.text,
        'email': emailCtr.text,
        'phone_no': phoneNumberCtr.text,
        'date_of_birth': dobCtr.text,
        'password': passCtr.text,
        'password_confirmation': passCtr.text,
        'gender': genderDropdown.toLowerCase(),
        'address': '${cityCtr.text}, ${countryCtr.text}',
        'country': selectedCountry,
        'city': cityCode,
        'reference_code': referralCodeCtr.text,
        'language': languageId,
      };

      //get response from ApiClient
      dynamic res = await MerchantAuthServices().userSignUp(data: userData);
      showSignUpResult(res);
    }
  }

  void showSignUpResult(Map<String, dynamic> res) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    //checks if there is no error in the response body.
    //if error is not present, navigate the users to Login Screen.

    if (res['message'] == 'success') {
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => User_Verification(email: emailCtr.text)));
    } else {
      setState(() {
        isLoading = false;
      });
      //if error is present, display a snackbar showing the error messsage
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Message: ${res['message']}'),
        backgroundColor: Colors.red.shade300,
        action: SnackBarAction(
          label: res['error'] == 'The email has already been taken'
              ? 'Next'
              : 'Close',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        User_Verification(email: emailCtr.text)));
          },
        ),
      ));
    }
  }
}
