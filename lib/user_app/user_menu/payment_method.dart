import 'package:SiBuy/constant/app_styles.dart';
import 'package:flutter/material.dart';

import '../../constant/color_constant.dart';
import 'card_screen.dart';

class Payments extends StatelessWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.APP_PRIMARY_COLOR,
          title: const Text('Payment Methods'),
        ),
        //LIST WITH TWO PAYMENT METHODS
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              //PAYPAL
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFF66000),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/paypal.png',
                    height: 50,
                    width: 50,
                  ),
                  title: const Text(
                    'Paypal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              Insets.gapH15,
              //CREDIT CARD
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFF66000),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => CustomCardPaymentScreen()),
                    );
                  },
                  leading: Image.asset(
                    'assets/images/credit.png',
                    height: 50,
                    width: 50,
                  ),
                  title: const Text(
                    'Credit Card',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              Insets.gapH15,
              // //CREDIT CARD
              // Container(
              //   decoration: BoxDecoration(
              //     color: Color(0xFFFF66000),
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.5),
              //         spreadRadius: 5,
              //         blurRadius: 7,
              //         offset: const Offset(0, 3), // changes position of shadow
              //       ),
              //     ],
              //   ),
              //   child: ListTile(
              //     onTap: () {},
              //     leading: Image.asset(
              //       'assets/images/credit.png',
              //       height: 50,
              //       width: 50,
              //     ),
              //     title: const Text(
              //       'WechatPay',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 20,
              //       ),
              //     ),
              //     trailing: const Icon(
              //       Icons.arrow_forward_ios,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // Insets.gapH15,
              // //CREDIT CARD
              // Container(
              //   decoration: BoxDecoration(
              //     color: Color(0xFFFF66000),
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.5),
              //         spreadRadius: 5,
              //         blurRadius: 7,
              //         offset: const Offset(0, 3), // changes position of shadow
              //       ),
              //     ],
              //   ),
              //   child: ListTile(
              //     onTap: () {},
              //     leading: Image.asset(
              //       'assets/images/credit.png',
              //       height: 50,
              //       width: 50,
              //     ),
              //     title: const Text(
              //       'AliPay',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 20,
              //       ),
              //     ),
              //     trailing: const Icon(
              //       Icons.arrow_forward_ios,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // Insets.gapH15,
              // //CREDIT CARD
              // Container(
              //   decoration: BoxDecoration(
              //     color: Color(0xFFFF66000),
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.5),
              //         spreadRadius: 5,
              //         blurRadius: 7,
              //         offset: const Offset(0, 3), // changes position of shadow
              //       ),
              //     ],
              //   ),
              //   child: ListTile(
              //     onTap: () {},
              //     leading: Image.asset(
              //       'assets/images/credit.png',
              //       height: 50,
              //       width: 50,
              //     ),
              //     title: const Text(
              //       'PiPay',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 20,
              //       ),
              //     ),
              //     trailing: const Icon(
              //       Icons.arrow_forward_ios,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // Insets.gapH15,
              // //CREDIT CARD
              // Container(
              //   decoration: BoxDecoration(
              //     color: Color(0xFFFF66000),
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.5),
              //         spreadRadius: 5,
              //         blurRadius: 7,
              //         offset: const Offset(0, 3), // changes position of shadow
              //       ),
              //     ],
              //   ),
              //   child: ListTile(
              //     onTap: () {},
              //     leading: Image.asset(
              //       'assets/images/credit.png',
              //       height: 50,
              //       width: 50,
              //     ),
              //     title: const Text(
              //       'UnionPay',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 20,
              //       ),
              //     ),
              //     trailing: const Icon(
              //       Icons.arrow_forward_ios,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
