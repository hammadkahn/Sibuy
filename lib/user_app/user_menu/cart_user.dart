import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:SiBuy/shared/custom_button.dart';
import 'package:SiBuy/user_app/user_menu/order_status.dart';

import 'package:provider/provider.dart';

import '../../constant/app_styles.dart';
import '../../constant/color_constant.dart';
import '../../constant/helper.dart';
import '../../providers/order.dart';
import '../../shared/no_internet_widget.dart';
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

  bool isInternetAvailable = true;

  @override
  void initState() {
    // TODO: implement initState
    UiUtils.checkInternet().then((value){
      isInternetAvailable = value;
      setState(() { });
    });
    getCity();
    super.initState();
  }

  getCity() async {
    if(widget.token == ""){
      userLocation = "Phnom Phen";
    }
    else{
      userLocation = await AppHelper.getPref('city');
    }
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          backgroundColor: AppColors.APP_PRIMARY_COLOR,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 32, top: 17),
          child: !isInternetAvailable ? NoInternetWidget() : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Consumer<Cart>(
                      builder: ((__, value, _) {
                        return value.cartMap.isEmpty
                            ? const Center(
                                child: Text('Your cart is empty'),
                              )
                            : ListView.separated(
                                itemCount: value.cartMap.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 15);
                                },
                                itemBuilder: ((context, index) {
                                  productId = value.cartMap.values.toList()[index].id;
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
                return value.cartMap.isEmpty ? Container() : CustomButton(
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
                                  imgUrl: '${value.cartMap.values.toList()[0].path!}/${value.cartMap.values.toList()[0].image!}')));
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
