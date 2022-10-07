import 'package:flutter/material.dart';

class user_review extends StatelessWidget {
  const user_review(
      {Key? key, required this.review, required this.reviewSender})
      : super(key: key);
  final String review;
  final String reviewSender;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/slt.png', width: 35, height: 35),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review,
                style: const TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff414042))),
            Text(reviewSender,
                style: const TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff818181))),
          ],
        ),
        const SizedBox(
          width: 40,
        ),
        Image.asset('assets/images/rate.png', width: 18, height: 18),
        Image.asset('assets/images/rate.png', width: 18, height: 18),
        Image.asset('assets/images/rate.png', width: 18, height: 18),
        Image.asset('assets/images/rate.png', width: 18, height: 18),
        Image.asset('assets/images/rate.png', width: 18, height: 18),
        const SizedBox(height: 12),
      ],
    );
  }
}
