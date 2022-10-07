import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gigi_app/shared/custom_button.dart';
import 'package:gigi_app/user_app/user_menu/order_status1.dart';
import 'package:gigi_app/user_app/user_menu/user_menu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/order.dart';
import 'cart_deals.dart';

class Cart_user extends StatefulWidget {
  const Cart_user({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<Cart_user> createState() => _Cart_userState();
}

class _Cart_userState extends State<Cart_user> {
  String? productId;

  String userLocation = 'Loading...';

  Future<void> getUserAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      userLocation =
          '${preferences.getString('city')}, ${preferences.getString('country')}';
    });
  }

  @override
  void didChangeDependencies() {
    getUserAddress();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => User_bar(token: widget.token)));
                        },
                        child: Image.asset('assets/images/arrow-left.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userLocation,
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
                child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Consumer<Cart>(
                      builder: ((__, value, _) {
                        return value.cartMap.isEmpty
                            ? const Center(
                                child: Text('Your cart is empty'),
                              )
                            : ListView.builder(
                                itemCount: value.cartMap.length,
                                itemBuilder: ((context, index) {
                                  productId =
                                      value.cartMap.values.toList()[index].id;

                                  return Slidable(
                                      endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) => {
                                                value.removeItem(value
                                                    .cartMap.values
                                                    .toList()[index]
                                                    .id!)
                                              },
                                              backgroundColor: Colors.red,
                                              icon: Icons.delete,
                                            )
                                          ]),
                                      child: cart_deals(
                                        cart: value.cartMap.values
                                            .toList()[index],
                                        token: widget.token,
                                        index: index,
                                      ));
                                }),
                              );
                      }),
                    )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 54,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        color: Color(0xff0D9BFF),
                        size: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Add More Offers',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0D9BFF))),
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<Cart>(builder: (__, value, _) {
                return CustomButton(
                  text: 'Get this Offer',
                  onPressed: value.cartMap.isEmpty
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please add a deal to the cart first'),
                            ),
                          );
                        }
                      : () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (currentContext) => status_1(
                                  id: int.parse(productId!),
                                  token: widget.token,
                                  location: userLocation,
                                  imgUrl:
                                      '${value.cartMap.values.toList()[0].path!}/${value.cartMap.values.toList()[0].image!}')));
                        },
                );
              }),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
