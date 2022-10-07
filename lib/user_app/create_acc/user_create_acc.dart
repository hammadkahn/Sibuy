import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gigi_app/services/auth/authentication.dart';
import 'package:gigi_app/shared/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
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
  final genderCtr = TextEditingController();

  var isLoading = false;

  double? latitued = 0.0;
  double? longitude = 0.0;
  Country? selectedCountry;
  @override
  void initState() {
    selectedCountry = const Country(
      name: "Azerbaijan",
      flag: "🇦🇿",
      code: "AZ",
      dialCode: "994",
      minLength: 9,
      maxLength: 9,
    );
    debugPrint(countryCtr.text);
    super.initState();
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
                TextFormField(
                  controller: genderCtr,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'gender',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please speicify your gender';
                    }
                    return null;
                  },
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
                TextFormField(
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
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'email is required';
                    }
                    return null;
                  },
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
                    textInputAction: TextInputAction.next,
                    controller: countryCtr,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.arrow_drop_down),
                        onPressed: () => showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => SizedBox(
                            height: MediaQuery.of(context).size.height / 1.3,
                            child: CountryPickerDialog(
                                searchText: 'Search Country',
                                countryList: countries,
                                onCountryChanged: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                    countryCtr.text = value.name;
                                  });
                                },
                                selectedCountry: selectedCountry!,
                                filteredCountries: countries),
                          ),
                        ),
                      ),
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
                TextFormField(
                  controller: cityCtr,
                  textInputAction: TextInputAction.done,
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
                // SelectState(
                //   onCountryChanged: (value) {
                //     setState(() {
                //       // countryValue = value;
                //     });
                //   },
                //   onStateChanged: (value) {
                //     setState(() {
                //       // stateValue = value;
                //     });
                //   },
                //   onCityChanged: (value) {
                //     setState(() {
                //       // cityValue = value;
                //     });
                //   },
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
    debugPrint(address[0].locality);
    latitued = currentLocation.latitude;
    longitude = currentLocation.longitude;
    countryCtr.text = address[0].country!;
    cityCtr.text = address[0].subAdministrativeArea!;

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
        'date_of_birth': dobCtr.text,
        'password': passCtr.text,
        'password_confirmation': passCtr.text,
        'gender': genderCtr.text,
        'address': '$latitued, $longitude, ${cityCtr.text}, ${countryCtr.text}',
        'country': countryCtr.text,
        'city': cityCtr.text,
        'lat': latitued.toString(),
        'long': longitude.toString(),
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
