import 'package:flutter/material.dart';
import 'package:gigi_app/shared/custom_button.dart';
import 'package:gigi_app/user_app/user_menu/my_qrs.dart';

class stats3 extends StatelessWidget {
  const stats3({Key? key, required this.token, required this.productName})
      : super(key: key);
  final String token;
  final String? productName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height - 120,
            width: MediaQuery.of(context).size.width - 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  'Your Offer',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                      color: Color(0xFF8E8EA9)),
                ),
                Text(productName ?? '"title is empty"',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Mulish',
                        color: Color(0xFFff6600))),
                const Text(
                  'is Successfuly added in MyGiGI',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                      color: Color(0xFF8E8EA9)),
                ),
                Expanded(
                    child: Image.asset(
                  'assets/images/stat.png',
                  height: 369,
                  width: 327,
                )),
                CustomButton(
                  text: 'Go to My Discounts',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => My_Qrs(token: token)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
