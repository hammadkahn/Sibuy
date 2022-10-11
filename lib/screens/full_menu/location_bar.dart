import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/screens/full_menu/profile.dart';
import 'package:SiBuy/services/branch/branch_services.dart';

class location_bar extends StatefulWidget {
  const location_bar({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<location_bar> createState() => _location_barState();
}

class _location_barState extends State<location_bar> {
  List<dynamic>? items = List.empty(growable: true);
  List<dynamic>? data;
  String? selectedValue;
  Future<List> getAllBrachesDropdown() async {
    final result = await BranchServices().getBranchesList(token: widget.token);
    for (var i in result['data']) {
      items!.add(i['name']);
      print(items);
    }
    return items!;
  }

  @override
  void initState() {
    getAllBrachesDropdown().whenComplete(() {
      print('data : $data');
    }).then((value) {
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/Vector.png'),
        Padding(
          padding: const EdgeInsets.only(left: 10.94),
          child: data == null
              ? const Text('fetching...')
              : DropdownButton2(
                  icon: const SizedBox(),
                  isExpanded: true,
                  hint: Text(
                    data!.isEmpty ? 'no branch' : data![0]!,
                    style: const TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFff6600)),
                    overflow: TextOverflow.ellipsis,
                  ),
                  items: data!
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFff6600)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                  underline: const SizedBox(),
                  buttonHeight: 30,
                  buttonWidth: 200,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 8),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  buttonElevation: 0,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 200,
                  dropdownWidth: 160,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(-20, 0),
                ),
        ),
        const Spacer(),
        InkWell(
          child: Image.asset('assets/images/drawer.png'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Profile(
                      token: widget.token,
                      isLeadingIcon: true,
                    )));
          },
        )
      ],
    );
  }
}
