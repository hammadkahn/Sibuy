import 'dart:io';

import 'package:SiBuy/providers/deal_provider.dart';
import 'package:SiBuy/services/deals/merchant_deal_services.dart';
import 'package:SiBuy/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Add_deal extends StatefulWidget {
  const Add_deal({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<Add_deal> createState() => _Add_dealState();
}

class _Add_dealState extends State<Add_deal> {
  DealProvider? _provider;
  final _key = GlobalKey<FormState>();

  final dobCtr = TextEditingController();
  final offerNameCtr = TextEditingController();
  final productNameCtr = TextEditingController();
  final descriptionCtr = TextEditingController();
  final discountCtr = TextEditingController();
  final productPriceCtr = TextEditingController();
  final expiryCtr = TextEditingController();
  final reedemExpiryCtr = TextEditingController();
  final tag0Ctr = TextEditingController();
  final tag1Ctr = TextEditingController();
  final tag2Ctr = TextEditingController();
  final limitCtr = TextEditingController();
  final isSponseredCtr = TextEditingController();

  bool? switchListTileValue;

  // Initial Selected Value
  String dropdownvalue = 'English';
  String category = 'For Men';
  String? languageId;
  String? categoyId;

  // List of items in our dropdown menu
  // var items;
  ValueNotifier<bool> isLoaded = ValueNotifier(false);
  ValueNotifier<bool> isSubmitted = ValueNotifier(false);
  File? image;
  File? video;
  Future pickimage() async {
    try {
      final Image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (Image == null) return;
      final imageTemporary = File(Image.path);
      setState(() {
        image = imageTemporary;
      });
      image = imageTemporary;
    } on PlatformException catch (e) {
      print("failed to load $e");
    }
  }

  Future pickVideo() async {
    try {
      final pickedFile = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(seconds: 59),
      );
      if (pickedFile != null) {
        setState(() {
          video = File(pickedFile.path);
        });

        debugPrint('image url: $video');
      }
    } on PlatformException catch (e) {
      debugPrint('failed to load $e');
    }
  }

  @override
  void initState() {
    _provider = Provider.of<DealProvider>(context, listen: false);

    super.initState();
  }

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
      //text forms for adding deals
      body: SafeArea(
        child: Form(
          key: _key,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    'Add Offers',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //offer name
                  const Text(
                    'Offer Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: offerNameCtr,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Offer Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter details';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //discount
                  const Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: discountCtr,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Discount',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter details';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //product name
                  const Text(
                    'Product Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: productNameCtr,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Product Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter details';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //product price
                  const Text(
                    'Procuct Price',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: productPriceCtr,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter product Price',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter details';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //deal expiry
                  const Text(
                    'Deal Sale Expiry',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: TextFormField(
                        controller: expiryCtr,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.calendar_today_rounded),
                          labelText: 'Deal Sale Expiry',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFEAEAEF)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFEAEAEF)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter details';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickdate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1970),
                              lastDate: DateTime(2030));
                          if (pickdate != null) {
                            setState(() {
                              expiryCtr.text =
                                  DateFormat('yyyy-MM-dd').format(pickdate);
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //redeem expiry
                  const Text(
                    'Deal Redemption Expiry',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: TextFormField(
                        controller: reedemExpiryCtr,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.calendar_today_rounded),
                            labelText: 'Deal Redemption Expiry',
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter details';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickdate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1970),
                              lastDate: DateTime(2030));
                          if (pickdate != null) {
                            setState(() {
                              reedemExpiryCtr.text =
                                  DateFormat('yyyy-MM-dd').format(pickdate);
                            });
                          }
                        },
                      ),
                    ),
                  ),

                  //tags
                  const Text(
                    'Tags',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: tag0Ctr,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Tags',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter details';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: TextFormField(
                              controller: tag1Ctr,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Tags',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter details';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: TextFormField(
                              controller: tag2Ctr,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Tags',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter details';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),

                  //category dropdown
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ValueListenableBuilder(
                      valueListenable: isLoaded,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return isLoaded.value == false
                            ? const CircularProgressIndicator()
                            : DropdownButton<String>(
                                isExpanded: true,
                                // Initial Value
                                value: category,

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
                                          categoyId = _provider!
                                              .catData.data![i].id
                                              .toString();
                                          break;
                                        }
                                      }
                                      print(categoyId);
                                    },
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    category = newValue!;
                                  });
                                },
                              );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //image
                  const Text(
                    'Deal Image',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      pickimage();
                    },
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Upload Image',
                            style: TextStyle(
                              fontSize: 16,
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //video
                  const Text(
                    'Deal Video( < 5MB)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      pickVideo();
                    },
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Upload Deal Video',
                            style: TextStyle(
                              fontSize: 16,
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //description
                  const Text(
                    'Deal Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: descriptionCtr,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Deal Description',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //limit
                  const Text(
                    'Limit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: limitCtr,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Offer Limit',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter details';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //language
                  const Text(
                    'Language',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ValueListenableBuilder(
                      valueListenable: isLoaded,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return isLoaded.value == false
                            ? const CircularProgressIndicator()
                            : DropdownButton<String>(
                                isExpanded: true,
                                // Initial Value
                                value: dropdownvalue,

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
                                    dropdownvalue = newValue!;
                                  });
                                },
                              );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //is sponsered switch
                  SwitchListTile(
                    value: switchListTileValue ??= true,
                    onChanged: (newValue) =>
                        setState(() => switchListTileValue = newValue),
                    title: Text(
                      'is sponsered?',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: const Color(0xFFBE5F26),
                          ),
                    ),
                    tileColor: const Color(0xFFF5F5F5),
                    dense: true,
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: EdgeInsets.zero,
                  ),

                  //submit button
                  SizedBox(
                    width: double.maxFinite,
                    child: ValueListenableBuilder(
                      valueListenable: isSubmitted,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return CustomButton(
                          text: 'Next',
                          onPressed: () {
                            isSubmitted.value = true;
                            if (_key.currentState!.validate()) {
                              _addOffer().whenComplete(
                                  () => isSubmitted.value = false);
                            } else {
                              isSubmitted.value = false;
                            }
                          },
                          isLoading: isSubmitted.value,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addOffer() async {
    Map<String, dynamic> data = {
      'name': offerNameCtr.text,
      'discount': discountCtr.text,
      'product_name': productNameCtr.text,
      'product_price': productPriceCtr.text,
      'expiry': expiryCtr.text,
      'redeem_expiry': reedemExpiryCtr.text,
      'tags[0]': tag0Ctr.text,
      'tags[1]': tag1Ctr.text,
      'tags[2]': tag2Ctr.text,
      'category': categoyId ?? '1',
      'images[0]': image!.path,
      'videos[0]': video!.path,
      'limit': limitCtr.text,
      'is_sponsered': switchListTileValue == true ? '1' : '0',
      'language': languageId ?? '1',
    };

    final result = await DealServices().createDeal(data, widget.token);
    if (result == '200') {
      isSubmitted.value = false;
      await showWarning('Offer submitted for approval');
      _clearAllFields();
    } else {
      isSubmitted.value = false;
      debugPrint(result);
      await showWarning(result);
    }
  }

  void _clearAllFields() {
    productNameCtr.clear();
    offerNameCtr.clear();
    discountCtr.clear();
    expiryCtr.clear();
    tag0Ctr.clear();
    tag1Ctr.clear();
    tag2Ctr.clear();
    limitCtr.clear();
    descriptionCtr.clear();
    reedemExpiryCtr.clear();
    productPriceCtr.clear();
  }

  Future<bool?> showWarning(String msg) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Api Response'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
        barrierDismissible: false,
      );
}
