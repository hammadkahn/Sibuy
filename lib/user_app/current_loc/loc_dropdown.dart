import 'package:flutter/material.dart';

class loc_dropdown extends StatefulWidget {
  const loc_dropdown({Key? key}) : super(key: key);

  @override
  State<loc_dropdown> createState() => _loc_dropdownState();
}

class _loc_dropdownState extends State<loc_dropdown> {
  String dropdownValue = 'Pakistan';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 25, left: 16),
        child: DropdownButton<String>(
          value: dropdownValue,
          isExpanded: true,
          icon: const Icon(
            Icons.arrow_drop_down,
          ),
          elevation: 16,
          style: const TextStyle(color: Color(0xFf8E8EA9)),
          underline: Container(height: 2, color: Colors.white),
          // underline: Container(
          //   height: 2,
          //   color: Colors.deepPurpleAccent,
          // ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['Pakistan', 'China', 'USA', 'UK', 'India']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 14, fontFamily: 'Mulish'),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
