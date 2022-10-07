import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Toggle_Button extends StatefulWidget {
  const Toggle_Button({Key? key}) : super(key: key);

  @override
  State<Toggle_Button> createState() => _Toggle_ButtonState();
}

class _Toggle_ButtonState extends State<Toggle_Button> {
  List<String> tags = [];

  // list of string options
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChipsChoice<String>.multiple(
      value: tags,
      onChanged: (val) => {setState(() => tags = val)},
      choiceItems: C2Choice.listFrom<String, String>(
        source: options,
        value: (i, v) => v,
        label: (i, v) => v,
      ),
      choiceStyle: const C2ChoiceStyle(
        backgroundColor: Colors.white,
        color: Color(0xFFA5A5BA),
        borderColor: Color(0xFFDCDCE4),
      ),
      wrapped: true,
      textDirection: TextDirection.rtl,
    );
  }
}
