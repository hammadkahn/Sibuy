import 'package:flutter/material.dart';
import 'package:gigi_app/providers/deal_provider.dart';
import 'package:gigi_app/providers/order.dart';
import 'package:gigi_app/user_app/user_menu/status3.dart';

import 'package:provider/provider.dart';

import '../../shared/custom_button.dart';
import 'order_detials.dart';

class status_1 extends StatefulWidget {
  const status_1(
      {Key? key,
      required this.token,
      required this.id,
      required this.imgUrl,
      required this.location})
      : super(key: key);
  final String token;
  final int id;
  final String imgUrl;
  final String location;

  @override
  State<status_1> createState() => _status_1State();
}

class _status_1State extends State<status_1> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: key,
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 32, top: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/images/arrow-left.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.location,
                          style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8E8EA9)),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Your cart',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF32324D)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: order_details(),
              ),
              const Spacer(),
              CustomButton(
                  text: "Get this Offer ➔",
                  isLoading: isLoading,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    final cart =
                        Provider.of<Cart>(key.currentContext!, listen: false);
                    String title = cart.cartMap.values.toList()[0].title!;
                    String price =
                        (int.parse(cart.cartMap.values.toList()[0].price!) *
                                int.parse(cart.cartMap.values.toList()[0].qty!))
                            .toString();
                    String totalPrice = cart
                        .calculateRealPrice(
                            int.parse(cart.cartMap.values.toList()[0].qty!),
                            cart.cartMap.values.toList()[0].discountOnPrice!,
                            cart.cartMap.values.toList()[0].price!)
                        .toString();
                    String discount =
                        cart.cartMap.values.toList()[0].discountOnPrice!;

                    addToCart(
                      cart.cartMap.values.toList()[0].id!,
                      cart.cartMap.values.toList()[0].qty!,
                      price,
                      totalPrice,
                      discount,
                      context,
                    ).whenComplete(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => stats3(
                            token: widget.token,
                            productName: title,
                          ),
                        ),
                      );
                      cart.clearCart();
                    }).then((value) {
                      setState(() {
                        isLoading = false;
                      });
                    });
                  }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addToCart(String id, String qty, String? price,
      String? totalPrice, String discount, BuildContext context) async {
    final dealProvider = Provider.of<DealProvider>(context, listen: false);
    Map<String, dynamic> data = {
      "deals[0][id]": id,
      "deals[0][quantity]": qty,
      "deals[0][price]": price ?? '0',
      "deals[0][total_price]": totalPrice ?? '0',
      "deals[0][discount]": discount,
    };
    print(data);
    await dealProvider.addToCart(widget.token, data);
    if (dealProvider.msg == 'success') {
      debugPrint('added successfully');
    } else {
      debugPrint('error ${dealProvider.msg}');
    }
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
