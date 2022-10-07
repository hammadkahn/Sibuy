import 'package:flutter/material.dart';

class Stacked_container extends StatelessWidget {
  const Stacked_container({Key? key, required this.discountAvailed})
      : super(key: key);
  final String discountAvailed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6, left: 6),
      child: Container(
        // color: Colors.red,
        width: MediaQuery.of(context).size.width - 48,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xffF8B2CB),
                ),
                child: Image.asset(
                  'assets/images/bg1.png',
                  color: Colors.white,
                  width: 10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Deal Radeem',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mulish',
                        color: Color(0xFF4A4A6A)),
                  ),
                  Text(
                    discountAvailed,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mulish',
                        color: Color(0xFF4A4A6A)),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
