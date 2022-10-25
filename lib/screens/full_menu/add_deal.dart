import 'dart:io';

import 'package:SiBuy/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Add_deal extends StatefulWidget {
  const Add_deal({Key? key}) : super(key: key);

  @override
  State<Add_deal> createState() => _Add_dealState();
}

class _Add_dealState extends State<Add_deal> {
  final dobCtr = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'English';

  // List of items in our dropdown menu
  var items = [
    'English',
    'Arabic',
    'French',
    'Spanish',
    'German',
  ];
  File? image;
  Future pickimage() async {
    try {
      final Image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (Image == null) return;
      final imageTemporary = File(Image.path);
      setState(() {
        this.image = imageTemporary;
      });
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print("failed to load $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //text forms for adding deals
        body: SafeArea(
            child: SingleChildScrollView(
      child: Center(
        child: Column(children: [
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
          Container(
            width: 300,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Offer Name',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
          Container(
            width: 300,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Deal Description',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Actual Price',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 300,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Actual Price',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
            child: Container(
              width: 300,
              child: Row(children: [
                const Text(
                  'Upload Image',
                  style: TextStyle(
                    fontSize: 20,
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

              // TextField(
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     hintText: 'Enter Deal Image',
              //   ),
              // ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
          Container(
            width: 300,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Offer Limit',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
          Container(
            width: 300,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Tags',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Price',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 300,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Voucher Price',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Language',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 300,
            child: DropdownButton(
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
          Text(
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
            child: Container(
              width: 300,
              child: TextField(
                controller: dobCtr,
                decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_today_rounded),
                    labelText: 'Deal Sale Expiry',
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
                      lastDate: DateTime(2030));
                  if (pickdate != null) {
                    setState(() {
                      dobCtr.text = DateFormat('dd-MM-yyyy').format(pickdate);
                    });
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
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
            child: Container(
              width: 300,
              child: TextField(
                controller: dobCtr,
                decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_today_rounded),
                    labelText: 'Deal Redemption Expiry',
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
                      lastDate: DateTime(2030));
                  if (pickdate != null) {
                    setState(() {
                      dobCtr.text = DateFormat('dd-MM-yyyy').format(pickdate);
                    });
                  }
                },
              ),
            ),
          ),
          Container(
              width: 300, child: CustomButton(text: 'Next', onPressed: () {})),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    )));
  }
}
