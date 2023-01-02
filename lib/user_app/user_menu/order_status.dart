import 'dart:developer';
import 'package:SiBuy/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:provider/provider.dart';
import '../../constant/app_styles.dart';
import '../../providers/order.dart';
import '../../shared/custom_button.dart';
import 'order_detials.dart';
import 'web_veiw.dart';

class status_1 extends StatefulWidget {
  const status_1({Key? key,
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
  Cart? cart;
  int _radioValue = 0;
  var totalAmount = 0.0;
  var totalSaving = 0.0;

  @override
  initState(){
    cart = Provider.of<Cart>(context, listen: false);
    super.initState();
  }

  calculate(price, discount){
    return price - discount;
  }

  calculateTotalAmount(Cart cart){
    totalAmount = 0;
    for (var element in cart.cartMap.values.toList()) {
      double discount = double.parse('0.${element.discountOnPrice}') * int.parse(element.price!);
      totalAmount += calculate(int.parse(element.qty!) * double.parse(element.price!), discount * int.parse(element.qty!));
    }
    return totalAmount;
  }

  calculateTotalSaving(Cart cart){
    totalSaving = 0;
    for (var element in cart.cartMap.values.toList()) {
      double discount = double.parse('0.${element.discountOnPrice}') * int.parse(element.price!);
      totalSaving += (discount * int.parse(element.qty!));
    }
    return totalSaving;
  }

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
              Expanded(
                child: ListView(
                  children: [
                    OrderDetails(cart: cart!, token: widget.token),
                  ],
                ),
              ),
              const Divider(thickness: 1, color: AppColors.APP_BLACK_COLOR,),
              const SizedBox(
                height: 10,
              ),
              //text for payment method
              const Text("Payment Method",
                  style: TextStyle(
                      fontFamily: "Mulish",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4A4A6A))),
              const Divider(
                color: Color(0xFFEAEAEF),
                thickness: 1,
              ),
              //blue text for credit card and radio button in last
              InkWell(
                onTap: (){
                  setState(() {
                    _radioValue = 0;
                  });
                },
                child: Row(
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
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    _radioValue = 1;
                  });
                },
                child: Row(
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
              ),
              Insets.gapH10,
              Row(
                children: [
                  const Text("Total To Pay",
                      style: TextStyle(
                          fontFamily: "Mulish",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A4A6A))),
                  const Spacer(),
                  Text(
                      '\$${calculateTotalAmount(cart!)} ',
                      // " \$ ${cart.calculateRealPrice(int.parse(cart.cartMap.values.toList()[index].qty!), cart.cartMap.values.toList()[index].discountOnPrice!, cart.cartMap.values.toList()[index].price!)}",
                      style: const TextStyle(
                          fontFamily: "Mulish",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.APP_PRIMARY_COLOR)),
                ],
              ),
              Insets.gapH10,
              Row(
                children: [
                  const Text("Total Saving",
                      style: TextStyle(
                          fontFamily: "Mulish",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A4A6A))),
                  const Spacer(),
                  Text(
                      '\$${calculateTotalSaving(cart!)} ',
                      // " \$ ${cart.calculateRealPrice(int.parse(cart.cartMap.values.toList()[index].qty!), cart.cartMap.values.toList()[index].discountOnPrice!, cart.cartMap.values.toList()[index].price!)}",
                      style: const TextStyle(
                          fontFamily: "Mulish",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.APP_PRIMARY_COLOR)),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                  text: "Get this Offer ➔",
                  isLoading: isLoading,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const WebViewExample()));
                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //     content: Text(
                    //         'This is service is not available right now')));
                    // setState(() {
                    //   isLoading = true;
                    // });
                    // final cart =
                    //     Provider.of<Cart>(key.currentContext!, listen: false);
                    // String title = cart.cartMap.values.toList()[0].title!;
                    // String price =
                    //     (int.parse(cart.cartMap.values.toList()[0].price!) *
                    //             int.parse(cart.cartMap.values.toList()[0].qty!))
                    //         .toString();
                    // String totalPrice = cart
                    //     .calculateRealPrice(
                    //         int.parse(cart.cartMap.values.toList()[0].qty!),
                    //         cart.cartMap.values.toList()[0].discountOnPrice!,
                    //         cart.cartMap.values.toList()[0].price!)
                    //     .toString();
                    // String discount =
                    //     cart.cartMap.values.toList()[0].discountOnPrice!;

                    // addToCart(
                    //   cart.cartMap.values.toList()[0].id!,
                    //   cart.cartMap.values.toList()[0].qty!,
                    //   price,
                    //   totalPrice,
                    //   discount,
                    //   context,
                    // ).whenComplete(() {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => stats3(
                    //         token: widget.token,
                    //         productName: title,
                    //       ),
                    //     ),
                    //   );
                    //   cart.clearCart();
                    // }).then((value) {
                    //   setState(() {
                    //     isLoading = false;
                    //   });
                    // });
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

    log('$data');
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
