import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:SiBuy/shared/custom_button.dart';
import 'package:SiBuy/user_app/user_menu/order_status1.dart';

import 'package:provider/provider.dart';

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

  // Future<void> getUserAddress() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     userLocation =
  //         '${preferences.getString('city')}, ${preferences.getString('country')}';
  //   });
  // }

  @override
  void didChangeDependencies() {
    // getUserAddress();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          backgroundColor: const Color(0xFFff6600),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 32, top: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              Consumer<Cart>(builder: (__, value, _) {
                return CustomButton(
                  text: 'Proceed To Payment',
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
