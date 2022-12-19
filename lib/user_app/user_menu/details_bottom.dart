import 'package:flutter/material.dart';
import '../../constant/color_constant.dart';
import '../../models/user_model.dart';

class bottom_detail extends StatelessWidget {
  const bottom_detail(
      {Key? key,
      required this.dealData,
      required this.price,
      required this.token})
      : super(key: key);
  final UserSingleDealData dealData;
  final String? price;

  final String token;

  @override
  Widget build(BuildContext context) {
    int value = 0;
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              dealData.dealIsExpired == 0 ? 'Available' : 'Expired',
              style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFA5A5BA)),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                dealData.name ?? 'no name',
                softWrap: true,
                style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A4A6A)),
              )),
          // Padding(
          //     padding: const EdgeInsets.only(top: 4),
          //     child: Row(
          //       children: [
          //         Image.asset(
          //           'assets/images/menu_location.png',
          //           width: 8,
          //           height: 8,
          //         ),
          //         Expanded(
          //           child: Text(
          //             'location',
          //             softWrap: true,
          //             style: const TextStyle(
          //                 fontFamily: 'Mulish',
          //                 fontSize: 10,
          //                 fontWeight: FontWeight.w600,
          //                 color: Color(0xFF8E8EA9)),
          //           ),
          //         ),
          //       ],
          //     )),
          Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Image.asset('assets/images/rating.png', width: 6, height: 6),
                  Text(
                    dealData.reviewAndCount == null
                        ? '0'
                        : dealData.reviewAndCount!.rating!,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 7,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF5F5F5F)),
                  ),
                  Text(
                    '(${dealData.reviewAndCount == null ? '0' : dealData.reviewAndCount!.count} reviews)',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 4,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5F5F5F)),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(top: 2.83),
              child: Row(
                children: [
                  const Text(
                    '\$',
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFF6767)),
                  ),
                  Text(
                    '${dealData.price ?? '0'}',
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFF6767)),
                  ),
                  const Text(
                    '\$',
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: AppColors.APP_PRIMARY_COLOR),
                  ),
                  Text(
                    price ?? '0',
                    style: const TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.APP_PRIMARY_COLOR),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    child: Center(
                      child: Text(
                        '${dealData.discountOnPrice ?? 0}% OFF',
                        style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w900,
                            color: AppColors.APP_PRIMARY_COLOR),
                      ),
                    ),
                  )
                ],
              )),
          Text(
            'Coupons Left:  ${dealData.limit ?? 0}',
            style: const TextStyle(
                fontFamily: 'Mulish',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8E8EA9)),
          ),
          const Text(
            'Description',
            style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8E8EA9)),
          ),
          Text(
            dealData.description ?? 'no description provided',
            style: const TextStyle(
                fontFamily: 'Mulish',
                fontSize: 8,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8E8EA9)),
          ),
        ],
      ),
    );
  }
}
