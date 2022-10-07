import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gigi_app/models/category_model.dart';
import 'package:gigi_app/services/auth/authentication.dart';
import 'package:gigi_app/shared/custom_button.dart';
import '../../services/categories/category_services.dart';
import '../../user_app/verify _code/user_verification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _key = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final countryCtr = TextEditingController();
  final cityCtr = TextEditingController();
  final passCtr = TextEditingController();
  final dobCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final phoneNumberCtr = TextEditingController();

  final desCtr = TextEditingController();
  final branchCtr = TextEditingController();
  final catCtr = TextEditingController();
  final catCtr2 = TextEditingController();

  double? longitude;
  double? latitued;
  //Signup
  var isLoading = false;
  bool catLoaded = false;
  List<CategoryData>? catData;

  Future<void> loadAllCategories() async {
    final result = await CategoryServices().getAllCategories();

    setState(() {
      catData = result.data;
    });
  }

  @override
  void initState() {
    loadAllCategories().whenComplete(() {
      setState(() {
        catLoaded = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                      'Look like you are new to us! Create an account for a complete experience.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8E8EA9))),
                ),
                TextFormField(
                  controller: nameCtr,
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
                    controller: phoneNumberCtr,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
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
                // TextFormField(
                //   controller: genderCtr,
                //   decoration: InputDecoration(
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                //       borderRadius: BorderRadius.circular(16),
                //     ),
                //     hintText: 'gender',
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please speicify your gender';
                //     }
                //     return null;
                //   },
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 16, bottom: 16),
                //   child: TextField(
                //     controller: dobCtr,
                //     decoration: InputDecoration(
                //         icon: const Icon(Icons.calendar_today_rounded),
                //         labelText: 'Date of Birth',
                //         enabledBorder: OutlineInputBorder(
                //           borderSide:
                //               const BorderSide(color: Color(0xFFEAEAEF)),
                //           borderRadius: BorderRadius.circular(16),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide:
                //               const BorderSide(color: Color(0xFFEAEAEF)),
                //           borderRadius: BorderRadius.circular(16),
                //         )),
                //     onTap: () async {
                //       DateTime? pickdate = await showDatePicker(
                //           context: context,
                //           initialDate: DateTime.now(),
                //           firstDate: DateTime(1970),
                //           lastDate: DateTime(2030));
                //       if (pickdate != null) {
                //         setState(() {
                //           dobCtr.text =
                //               DateFormat('dd-MM-yyyy').format(pickdate);
                //         });
                //       }
                //     },
                //   ),
                // ),
                TextFormField(
                  controller: emailCtr,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'email is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Column(
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.location_pin),
                      onPressed: () {
                        _determinePosition()
                            .whenComplete(() => debugPrint('fetched'))
                            .then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value),
                                ),
                              ),
                            );
                      },
                      label: const Text('Fetch your current location'),
                    ),
                    Text(
                      'For get your pricise location, Please Fetch your location',
                      style: TextStyle(fontSize: 10, color: Colors.grey[350]),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: TextFormField(
                    readOnly: true,
                    controller: countryCtr,
                    decoration: InputDecoration(
                      labelText: 'Country',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: TextFormField(
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: TextFormField(
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
                    controller: branchCtr,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Branch Name',
                      // suffix: Icon(Icons.visibility)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your branch name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: TextFormField(
                    controller: desCtr,
                    maxLines: 3,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Description',
                      // suffix: Icon(Icons.visibility)
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: catLoaded == false
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          itemCount: catData!.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 10),
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            return Text(
                                '${catData![index].id}: ${catData![index].name}');
                          }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: TextFormField(
                    controller: catCtr,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Enter only one Category id from above list',
                      // suffix: Icon(Icons.visibility)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter category';
                      }
                      return null;
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 26),
                //   child: TextFormField(
                //     controller: catCtr2,
                //     keyboardType: TextInputType.number,
                //     decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                //         borderRadius: BorderRadius.circular(16),
                //       ),
                //       hintText: 'Enter Second Category id',
                //       // suffix: Icon(Icons.visibility)
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter category';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
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

  Future<String> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }
// When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final address = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    debugPrint(address[0].country);
    debugPrint(address[0].subLocality);
    latitued = currentLocation.latitude;
    longitude = currentLocation.longitude;
    countryCtr.text = address[0].country!;
    cityCtr.text = address[0].locality!;

    return 'Location fetched successfully';
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

        'password': passCtr.text,
        'password_confirmation': passCtr.text,
        'branch_name': branchCtr.text,
        'address': '$latitued, $longitude, ${cityCtr.text}, ${countryCtr.text}',
        'description': desCtr.text,
        // 'profile_picture': '',
        // 'logo': '',
        'country': countryCtr.text,
        'city': cityCtr.text,
        'lat': '${latitued ?? ''}',
        'long': '${longitude ?? ''}',
        'categories[0]': catCtr.text,
        'categories[1]': catCtr.text,
      };

      //get response from ApiClient
      dynamic res = await MerchantAuthServices()
          .merchantRegisteration(data: userData)
          .onError((error, stackTrace) {
        setState(() {
          isLoading = false;
        });
        return error as Map<String, dynamic>;
      });
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
        content: Text('Message: ${res['error']}'),
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
