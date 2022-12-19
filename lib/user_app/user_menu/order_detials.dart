import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apis/api_urls.dart';
import '../../constant/color_constant.dart';
import '../../providers/order.dart';

class order_details extends StatefulWidget {
  const order_details({Key? key}) : super(key: key);

  @override
  State<order_details> createState() => _order_detailsState();
}

class _order_detailsState extends State<order_details> {
  int _radioValue = 0;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cart.cartMap.length,
        itemBuilder: ((context, index) {
          double discount = double.parse(
                  '0.${cart.cartMap.values.toList()[index].discountOnPrice}') *
              int.parse(cart.cartMap.values.toList()[index].price!);
          log(cart.cartMap.values.toList()[index].qty.toString());
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
              child: ExpandablePanel(
                controller: ExpandableController(
                  initialExpanded: true,
                ),
                header: const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Offer details and discount",
                    style: TextStyle(
                        fontFamily: "Mulish",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8E8EA9)),
                  ),
                ),
                collapsed: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      cart.cartMap.values.toList()[index].image == ''
                          ? Image.asset(
                              'assets/images/expand_pic.png',
                              height: 40,
                              width: 40,
                            )
                          : Image.network(
                              '${ApiUrls.imgBaseUrl}${cart.cartMap.values.toList()[index].path}/${cart.cartMap.values.toList()[index].image}}',
                              height: 40,
                              width: 40,
                            ),
                      Text(
                        cart.cartMap.values.toList()[index].title!,
                        style: const TextStyle(
                            fontFamily: "Mulish",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF32324D)),
                      ),
                      const Spacer(),
                      Text(
                        "${cart.cartMap.values.toList()[index].qty} x",
                        style: const TextStyle(
                            fontFamily: "Mulish",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA5A5BA)),
                      ),
                      Text(
                        "${cart.cartMap.values.toList()[index].discountOnPrice}% off",
                        style: const TextStyle(
                            fontFamily: "Mulish",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.APP_PRIMARY_COLOR),
                      ),
                    ],
                  ),
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        cart.cartMap.values.toList()[index].image == ''
                            ? Image.asset(
                                'assets/images/expand_pic.png',
                                height: 40,
                                width: 40,
                              )
                            : Image.network(
                                '${ApiUrls.imgBaseUrl}${cart.cartMap.values.toList()[index].path}/${cart.cartMap.values.toList()[index].image}}',
                                height: 40,
                                width: 40,
                              ),
                        Text(
                          cart.cartMap.values.toList()[index].title!,
                          style: const TextStyle(
                              fontFamily: "Mulish",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF32324D)),
                        ),
                        const Spacer(),
                        Text(
                          "${cart.cartMap.values.toList()[index].qty} x",
                          style: const TextStyle(
                              fontFamily: "Mulish",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFA5A5BA)),
                        ),
                        Text(
                          "${cart.cartMap.values.toList()[index].discountOnPrice}% off",
                          style: const TextStyle(
                              fontFamily: "Mulish",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.APP_PRIMARY_COLOR),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Divider(
                        color: Color(0xFFEAEAEF),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Row(
                        children: [
                          const Text("Real price",
                              style: TextStyle(
                                  fontFamily: "Mulish",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF666687))),
                          const Spacer(),
                          Text(
                              " \$${int.parse(cart.cartMap.values.toList()[index].qty!) * double.parse(cart.cartMap.values.toList()[index].price!)} ",
                              style: const TextStyle(
                                  fontFamily: "Mulish",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF4A4A6A))),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Discount",
                            style: TextStyle(
                                fontFamily: "Mulish",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF666687))),
                        const Spacer(),
                        Text(
                            " \$ ${discount * int.parse(cart.cartMap.values.toList()[index].qty!)}",
                            style: const TextStyle(
                                fontFamily: "Mulish",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4A4A6A))),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Divider(
                        color: Color(0xFFEAEAEF),
                        thickness: 1,
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Total Price",
                            style: TextStyle(
                                fontFamily: "Mulish",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4A4A6A))),
                        const Spacer(),
                        Text(
                            " \$ ${cart.calculateRealPrice(int.parse(cart.cartMap.values.toList()[index].qty!), cart.cartMap.values.toList()[index].discountOnPrice!, cart.cartMap.values.toList()[index].price!)}",
                            style: const TextStyle(
                                fontFamily: "Mulish",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.APP_PRIMARY_COLOR)),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Divider(
                        color: Color(0xFFEAEAEF),
                        thickness: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //text for payment method
                    const Text("Payment Method",
                        style: TextStyle(
                            fontFamily: "Mulish",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4A4A6A))),
                    const SizedBox(
                      height: 16,
                    ),
                    //blue text for credit card and radio button in last
                    Row(
                      children: [
                        //icon for credit card

                        const Text("Credit Card",
                            style: TextStyle(
                                fontFamily: "Mulish",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4A4A6A))),
                        const Spacer(),
                        Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: (value) {
                            setState(() {
                              _radioValue = 0;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Paypal",
                            style: TextStyle(
                                fontFamily: "Mulish",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4A4A6A))),
                        const Spacer(),
                        Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: (value) {
                            setState(() {
                              _radioValue = 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
