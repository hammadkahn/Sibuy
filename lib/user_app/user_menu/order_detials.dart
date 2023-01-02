import 'dart:developer';
import 'package:SiBuy/constant/size_constants.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../apis/api_urls.dart';
import '../../constant/color_constant.dart';
import '../../providers/order.dart';
import 'deals_details.dart';

class OrderDetails extends StatelessWidget {
  Cart cart;
  String token;
  OrderDetails({Key? key, required this.cart, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: cart.cartMap.length,
        padding: const EdgeInsets.only(top: 15),
        itemBuilder: ((context, index) {
          double discount = double.parse(
                  '0.${cart.cartMap.values.toList()[index].discountOnPrice}') *
              int.parse(cart.cartMap.values.toList()[index].price!);
          log(cart.cartMap.values.toList()[index].qty.toString());
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(15),
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
                collapsed: GestureDetector(
                  onTap: (){

                  },
                  child: Padding(
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
                                '${ApiUrls.imgBaseUrl}${cart.cartMap.values.toList()[index].path}/${cart.cartMap.values.toList()[index].image}',
                                height: 40,
                                width: 40,
                              ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.44,
                          child: Text(
                            cart.cartMap.values.toList()[index].title!,
                            maxLines: 2,
                            style: const TextStyle(
                                fontFamily: "Mulish",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF32324D)),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${cart.cartMap.values.toList()[index].qty} x ",
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
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
                          isScrollControlled: true,
                          context: context,
                          builder: (ct) => Wrap(
                            children: [
                              Details_deals(
                                context: context,
                                dealId: cart.cartMap.values.toList()[index].image,
                                token: token,
                              ),
                            ],
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          cart.cartMap.values.toList()[index].image == ''
                              ? Image.asset(
                                  'assets/images/expand_pic.png',
                                  height: 40,
                                  width: 40,
                                )
                              : Image.network(
                                  '${ApiUrls.imgBaseUrl}${cart.cartMap.values.toList()[index].path}/${cart.cartMap.values.toList()[index].image}',
                                  height: 40,
                                  width: 40,
                                ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.44,
                            child: Text(
                              cart.cartMap.values.toList()[index].title!,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontFamily: "Mulish",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF32324D)),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${cart.cartMap.values.toList()[index].qty} x ",
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
                    const Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Divider(
                        color: Color(0xFFEAEAEF),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                      padding: EdgeInsets.only(top: 5, bottom: 5),
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
                          '\$ ${calculate(int.parse(cart.cartMap.values.toList()[index].qty!) * double.parse(cart.cartMap.values.toList()[index].price!), discount * int.parse(cart.cartMap.values.toList()[index].qty!))}',
                            // " \$ ${cart.calculateRealPrice(int.parse(cart.cartMap.values.toList()[index].qty!), cart.cartMap.values.toList()[index].discountOnPrice!, cart.cartMap.values.toList()[index].price!)}",
                            style: const TextStyle(
                                fontFamily: "Mulish",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.APP_PRIMARY_COLOR)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        })
    );
  }

  calculate(price, discount){
    return price - discount;
  }
}
