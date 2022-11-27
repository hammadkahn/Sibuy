import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:SiBuy/services/auth/authentication.dart';
import 'package:SiBuy/shared/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:provider/provider.dart';
import '../../providers/deal_provider.dart';
import '../../user_app/verify _code/user_verification.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DealProvider? _provider;
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
  final patentCtr = TextEditingController();
  final registerationCtr = TextEditingController();
  final openingTimeCtr = TextEditingController();
  final closingTimeCtr = TextEditingController();

  double? longitude;
  double? latitued;
  Country? selectedCountry;
  String? categoyId_1;
  String? categoyId_2;
  String? languageId;

  File? logoImage;
  int radioValue = 0;

  //logo picker
  Future _logoPicker() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        logoImage = imageTemporary;
      });
      logoImage = imageTemporary;
    } on PlatformException catch (e) {
      print("failed to load $e");
    }
  }

  File? profile_image;
  //profile image picker
  Future profilePicker() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        profile_image = imageTemporary;
      });
      profile_image = imageTemporary;
    } on PlatformException catch (e) {
      log("failed to load $e");
    }
  }

  FilePickerResult? result;
  PlatformFile? file;

  //document 1 picker
  void pickDocument_1() async {
    result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
        allowMultiple: true);
    if (result == null) return;
    file = result!.files.first;
    setState(() {});
  }

  FilePickerResult? resultt;
  PlatformFile? filee;

  //docunmet 2 picker
  void pickDocument_2() async {
    resultt = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
        allowMultiple: true);
    if (result == null) return;
    filee = resultt!.files.first;
    setState(() {});
  }

  //Signup
  bool isLoading = false;
  bool catLoaded = false;

  ValueNotifier<bool> isLoaded = ValueNotifier(false);

  // Future<void> loadAllCategories() async {
  //   final result = await CategoryServices().getAllCategories();

  //   setState(() {
  //     catData = result.data;
  //   });
  // }

  String category_2 = 'For Men';

  // Initial Selected Value
  String category_1 = 'For Men';

  String langDropdownvaluee = 'English';

  // List of items in our dropdown menu
  String op_dropdownvalue = 'Item 1';

  // // List of items in our dropdown menu
  // var op = [
  //   'Item 1',
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  //   'Item 5',
  // ];

  @override
  void initState() {
    _provider = Provider.of<DealProvider>(context, listen: false);
    selectedCountry = const Country(
      name: "Azerbaijan",
      flag: "🇦🇿",
      code: "AZ",
      dialCode: "994",
      minLength: 9,
      maxLength: 9,
    );
    debugPrint(countryCtr.text);
    // loadAllCategories().whenComplete(() {
    //   setState(() {
    //     catLoaded = true;
    //   });
    // });

    super.initState();
  }

  TimeOfDay? _timeOfDay = const TimeOfDay(hour: 9, minute: 00);
  void _showtimepicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => setState(() {
              _timeOfDay = value;
            }));
  }

  TimeOfDay? _closetimeOfDay = const TimeOfDay(hour: 6, minute: 00);
  void _closetimepicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => setState(() {
              _closetimeOfDay = value;
            }));
  }

  final notifications = [
    CheckBoxState(title: 'Monday'),
    CheckBoxState(title: 'Tuesday'),
    CheckBoxState(title: 'Wednesday'),
    CheckBoxState(title: 'Thursday'),
    CheckBoxState(title: 'Friday'),
    CheckBoxState(title: 'Saturday'),
    CheckBoxState(title: 'Sunday'),
  ];

  @override
  void didChangeDependencies() {
    _provider!
        .getAllLanguages()
        .then((value) => _provider!.getAllCat().whenComplete(() {
              isLoaded.value = true;
              // setState(() {
              //   // items = Provider.of<DealProvider>(context, listen: false).languages;
              // });
            }));
    super.didChangeDependencies();
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
                    hintText: 'Email (Optional)',
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  children: [
                    TextButton.icon(
                      icon: const Icon(
                        Icons.location_pin,
                        color: Colors.orange,
                      ),
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
                      label: const Text(
                        'Fetch your current location',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                    Text(
                      'To get your pricise location, Please Fetch your location',
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
                    controller: passCtr,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Confirm Password',
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
                  padding: const EdgeInsets.only(bottom: 26),
                  child: TextFormField(
                    controller: branchCtr,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Address',
                      // suffix: Icon(Icons.visibility)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
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
                const Text(
                  'Category 1',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // category 1 dropdown
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
                              value: category_1,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: _provider!.allCategories
                                  .map<DropdownMenuItem<String>>(
                                      (String items) {
                                return DropdownMenuItem<String>(
                                  value: items,
                                  child: Text(items),
                                  onTap: () {
                                    for (int i = 0;
                                        i < _provider!.allCategories.length;
                                        i++) {
                                      if (items ==
                                          _provider!.allCategories[i]) {
                                        categoyId_1 = _provider!
                                            .catData.data![i].id
                                            .toString();
                                        break;
                                      }
                                    }
                                    print(categoyId_1);
                                  },
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  category_1 = newValue!;
                                });
                              },
                            );
                    },
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Category 2',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //category 2 dropdown
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
                              value: category_2,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: _provider!.allCategories
                                  .map<DropdownMenuItem<String>>(
                                      (String items) {
                                return DropdownMenuItem<String>(
                                  value: items,
                                  child: Text(items),
                                  onTap: () {
                                    for (int i = 0;
                                        i < _provider!.allCategories.length;
                                        i++) {
                                      if (items ==
                                          _provider!.allCategories[i]) {
                                        categoyId_1 = _provider!
                                            .catData.data![i].id
                                            .toString();
                                        break;
                                      }
                                    }
                                    print(categoyId_1);
                                  },
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  category_2 = newValue!;
                                });
                              },
                            );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //language dropdwon
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
                                        i < _provider!.allCategories.length;
                                        i++) {
                                      if (items ==
                                          _provider!.allCategories[i]) {
                                        languageId = _provider!
                                            .catData.data![i].id
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
                const SizedBox(
                  width: 10,
                ),
                //operation days
                const Text(
                  'Operation Days',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...notifications.map(buildSingleCheckbox).toList(),

                const Text(
                  'Opening Time',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      'From : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _timeOfDay!.format(context).toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    MaterialButton(
                      onPressed: _showtimepicker,
                      color: Colors.orange,
                      child: Text('Opening Time'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Closing Time',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      'To : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _closetimeOfDay!.format(context).toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    MaterialButton(
                      onPressed: _closetimepicker,
                      color: Colors.orange,
                      child: Text('Closing Time'),
                    ),
                  ],
                ),

                // profile pic
                InkWell(
                  onTap: () {
                    profilePicker();
                  },
                  child: SizedBox(
                    width: 300,
                    child: Row(children: [
                      Container(
                        //rounded container for image
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: profile_image != null
                            ? Image.file(
                                profile_image!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Profile pic',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const Icon(
                        Icons.upload_file,
                        size: 30,
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                //logo pic
                InkWell(
                  onTap: () {
                    _logoPicker();
                  },
                  child: SizedBox(
                    width: 300,
                    child: Row(children: [
                      Container(
                        //rounded container for image
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: logoImage != null
                            ? Image.file(
                                logoImage!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'logo',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const Icon(
                        Icons.upload_file,
                        size: 30,
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Is registered with ministry of Commerce?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value as int;
                            });
                          },
                        ),
                        const Text('Yes'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value as int;
                            });
                            log(radioValue.toString());
                          },
                        ),
                        const Text('No'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                if (radioValue == 1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 26),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFEAEAEF)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Regeistration number',
                        // suffix: Icon(Icons.visibility)
                      ),
                    ),
                  ),
                if (radioValue == 1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 26),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFEAEAEF)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Patent Number',
                        // suffix: Icon(Icons.visibility)
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 15,
                ),

                //document 1 picker
                if (radioValue == 1)
                  InkWell(
                    onTap: () {
                      pickDocument_1();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Document Upload 0',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.upload_file,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                if (radioValue == 1)
                  Text(
                    'Document Name: $file',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(
                  height: 15,
                ),

                //document 2 picker
                if (radioValue == 1)
                  InkWell(
                    onTap: () {
                      pickDocument_2();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Document Upload 1',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.upload_file,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                if (radioValue == 1)
                  Text(
                    'Document Name: $filee',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
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
        'address': branchCtr.text,
        'description': desCtr.text,
        'profile_picture': profile_image!.path,
        'logo': logoImage!.path,
        'country': countryCtr.text,
        'city': cityCtr.text,
        'categories[0]': categoyId_1,
        'categories[1]': categoyId_2,
        'documents[0]': file!.path,
        'documents[1]': filee!.path,
        'registration_number': registerationCtr.text,
        'patent_number': patentCtr.text,
        'is_registered_with_ministry_of_commerce': radioValue,
        'opnening_time': openingTimeCtr.text,
        'closing_time': closingTimeCtr.text,
        'operation_days': op_dropdownvalue,
        'language': languageId,
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

  Widget buildSingleCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        title: Text(checkbox.title),
        value: checkbox.value,
        onChanged: (value) => setState(() => checkbox.value = value!),
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      );
}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({required this.title, this.value = false});
}
