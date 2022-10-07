import 'package:flutter/material.dart';

class Stacked_container2 extends StatelessWidget {
  const Stacked_container2(
      {Key? key, required this.totalActiveDeals, required this.title})
      : super(key: key);
  final String totalActiveDeals;
  final String title;

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
                  color: const Color(0xffD4A8F9),
                ),
                child: Image.asset(
                  'assets/images/vouch.png',
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mulish',
                        color: Color(0xFF4A4A6A)),
                  ),
                  Text(
                    totalActiveDeals,
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
