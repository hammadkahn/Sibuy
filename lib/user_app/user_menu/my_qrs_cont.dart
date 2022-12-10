import 'package:flutter/material.dart';
import 'package:SiBuy/models/cart_model.dart';
import 'package:SiBuy/user_app/user_menu/review.dart';
import 'package:SiBuy/user_app/user_menu/scan_qr.dart';
import 'package:intl/intl.dart';

import '../../services/user_merchant_services.dart';

class qr_cont extends StatefulWidget {
  const qr_cont({Key? key, required this.cartData, required this.token})
      : super(key: key);
  final CartData cartData;
  final String token;

  @override
  State<qr_cont> createState() => _qr_contState();
}

class _qr_contState extends State<qr_cont> {
  String? address = 'Loading...';

  Future<void> getMerchantAddress() async {
    final result = await UserMerchantServices().singleMerchantProfile(
      id: widget.cartData.merchantId.toString(),
      token: widget.token,
    );

    // setState(() {
    //   // address = result.data!.branches![0].address;
    // });
  }

  @override
  void didChangeDependencies() {
    getMerchantAddress();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 98 / 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFFE8E8E8),
        ),
        child: InkWell(
          onTap:
              // widget.cartData.availabilityStatus == "Available"
              // ?
              () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => scan_qr(
                qrCode: widget.cartData,
                token: widget.token,
              ),
            ),
          ),
          // : () => ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //         content: Text('Deal is expired'),
          //       ),
          //     ),
          child: Padding(
            padding: const EdgeInsets.only(top: 6, left: 26, right: 26),
            child: Column(
              key: widget.key,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Qr Code: ',
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000000)),
                    /*defining default style is optional */
                    children: <TextSpan>[
                      TextSpan(
                          text: ' 12345678',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFff6600))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      child: Text(widget.cartData.name!,
                          softWrap: true,
                          style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF32324D))),
                    ),
                    const Spacer(),
                    Text(
                      widget.cartData.availabilityStatus ?? 'Redeemed',
                      textAlign: TextAlign.right,
                      softWrap: true,
                      style: const TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF0D0D)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/menu_location.png',
                      width: 8,
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        address ?? 'loading...',
                        softWrap: true,
                        style: const TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF848484)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(children: [
                  const Text('Date Purchased: ',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8E8EA9))),
                  Text(
                      DateFormat('dd-MM-yyyy').format(
                          DateTime.parse(widget.cartData.purchaseDate!)),
                      style: const TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFff6600))),
                  const SizedBox(width: 10),
                  const Spacer(),
                  Container(
                    width: 90,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xFFff6600),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => review(
                                    dealId:
                                        widget.cartData.purchaseId.toString(),
                                    token: widget.token,
                                  )),
                        ),
                        child: const Text('★ Write a Review',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFFFFFFF))),
                      ),
                    ),
                  ),

                  //
                ]),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Redemption Expiry: ',
                        style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8E8EA9))),
                    Text(widget.cartData.expiry!,
                        style: const TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFff6600))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
