import 'dart:developer';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:SiBuy/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/color_constant.dart';
import '../../services/get_profile/get_user_info.dart';
import '../../shared/loader.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key, required this.token, required this.userData})
      : super(key: key);
  final String token;
  final Map<String, dynamic> userData;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  DealProvider? _provider;

  TextEditingController? nameCtr;
  TextEditingController? phoneNumberCtr;
  final countryCtr = TextEditingController();
  final cityCtr = TextEditingController();
  final dobCtr = TextEditingController();

  ValueNotifier<bool> isLoaded = ValueNotifier(false);

  String dropdownvalue = 'Male';
  String languageDropdownValue = 'English';
  String? languageId;
  String? countryCode;
  String? cityCode;

  //dropdown values for gender
  var items = [
    'Male',
    'Female',
    'Other',
  ];

  @override
  void initState() {
    _provider = Provider.of<DealProvider>(context, listen: false);
    super.initState();
    nameCtr = TextEditingController(text: widget.userData['name']);
    phoneNumberCtr = TextEditingController(text: widget.userData['phone_no']);
  }

  @override
  void didChangeDependencies() {
    _provider!
        .getAllLanguages()
        .then((value) => _provider!.getAllCountries())
        .whenComplete(() {
      isLoaded.value = true;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //my profile with editables form fields
      appBar: AppBar(
        backgroundColor: AppColors.APP_PRIMARY_COLOR,
        title: const Text('My Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: [
          //forms for user to edit
          const Text("Full Name",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 300 / 375,
            child: TextFormField(
              controller: nameCtr,
              decoration: InputDecoration(
                hintText: widget.userData['name'],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // const Text("Phone Number",
          //     style: TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black)),
          // const SizedBox(
          //   height: 5,
          // ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 300 / 375,
          //   child: TextFormField(
          //     controller: phoneNumberCtr,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       hintText: widget.userData['phone_no'],
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(20.0),
          //       ),
          //     ),
          //   ),
          // ),

          // const SizedBox(
          //   height: 20,
          // ),

          //dropdown for gender selection

          const Text("Gender",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width * 300 / 375,
            child: DropdownButton(
              underline: Container(),
              isExpanded: true,
              // Initial Value
              value: dropdownvalue,

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
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Country',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          //country dropdown
          ValueListenableBuilder(
            valueListenable: isLoaded,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return TextFormField(
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
                          height: MediaQuery.of(context).size.height / 1.3,
                          child: ListView.builder(
                            itemCount: _provider!.allCountries.data!.length,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  countryCode = _provider!
                                      .allCountries.data![index].id
                                      .toString();
                                  countryCtr.text = _provider!
                                      .allCountries.data![index].name!;
                                  if (countryCode != null) {
                                    _provider!.getAllCities(_provider!
                                        .allCountries.data![index].id
                                        .toString());
                                  }

                                  log(countryCode!);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 12, 15, 8),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: countryCtr.text,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'country field is required';
                  }
                  return null;
                },
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'City',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),

          //city dropdown
          TextFormField(
            onTap: () => countryCode == null || countryCode!.isEmpty
                ? ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select your country first'),
                    ),
                  )
                : showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height / 1.3,
                          child: ListView.builder(
                            itemCount: _provider!.allCities.data!.length,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  cityCode = _provider!
                                      .allCities.data![index].id
                                      .toString();
                                  cityCtr.text =
                                      _provider!.allCities.data![index].name!;

                                  log(cityCode!);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 12, 15, 8),
                                  child: Text(
                                      _provider!.allCities.data![index].name!),
                                ),
                              );
                            }),
                          ),
                        )),
            readOnly: true,
            controller: cityCtr,
            decoration: InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
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
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Language',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          //language dropdwon
          ValueListenableBuilder(
            valueListenable: isLoaded,
            builder: (BuildContext context, bool value, Widget? child) {
              return isLoaded.value == false
                  ? Loader()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        // Initial Value
                        value: languageDropdownValue,
                        underline: const SizedBox(),
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: _provider!.languages
                            .map<DropdownMenuItem<String>>((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                            onTap: () {
                              for (int i = 0;
                                  i < _provider!.languageData['data'].length;
                                  i++) {
                                if (items ==
                                    _provider!.languageData['data'][i]
                                        ['name']) {
                                  languageId = _provider!.languageData['data']
                                          [i]['id']
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
                            languageDropdownValue = newValue!;
                          });
                        },
                      ));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          //date of birth
          TextField(
            controller: dobCtr,
            textInputAction: TextInputAction.next,
            readOnly: true,
            decoration: InputDecoration(
                icon: const Icon(Icons.calendar_today_rounded,
                    color: AppColors.APP_PRIMARY_COLOR),
                labelText: 'Date of Birth',
                labelStyle: const TextStyle(color: AppColors.APP_BLACK_COLOR),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFEAEAEF)),
                  borderRadius: BorderRadius.circular(16),
                )),
            onTap: () async {
              DateTime? pickdate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1970),
                lastDate: DateTime(2030),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: AppColors.APP_PRIMARY_COLOR,
                      colorScheme: ColorScheme.light(
                        primary: AppColors.APP_PRIMARY_COLOR,
                      ),
                      buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
              );
              if (pickdate != null) {
                setState(() {
                  dobCtr.text = DateFormat('yyyy-MM-dd').format(pickdate);
                });
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 300 / 375,
              child: CustomButton(
                  text: 'Update',
                  onPressed: () {
                    updateProfile();
                  })),
        ],
      ),
    );
  }

  Future<void> updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log('[{"id":"${prefs.getInt('userId')}","address":"${cityCtr.text}, ${countryCtr.text}","country":"$countryCode","city":"$cityCode"}]');
    final Map<String, dynamic> data = {
      'name': nameCtr!.text,
      'phone_no': phoneNumberCtr!.text,
      'date_of_birth': dobCtr.text,
      'gender': dropdownvalue.toLowerCase(),
      'languages': '[{"language_id":"$languageId","is_default":"0"}]',
      'locations':
          '[{"address":"${cityCtr.text}, ${countryCtr.text}","country":"$countryCode","city":"$cityCode"}]',
    };
    final result =
        await UserInformation().updateUserProfile(widget.token, data);

    if (result['status'] == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result['message'])));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result['message'])));
    }
  }
}
