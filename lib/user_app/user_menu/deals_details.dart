import 'dart:developer';

import 'package:SiBuy/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/models/cart_model.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:provider/provider.dart';

import '../../apis/api_urls.dart';
import '../../constant/color_constant.dart';
import '../../models/user_model.dart';
import '../../providers/order.dart';
import '../../shared/loader.dart';
import 'details_bottom.dart';

class Details_deals extends StatefulWidget {
  Details_deals(
      {Key? key, this.dealId, required this.token, required this.context})
      : super(key: key);
  final String? dealId;
  final String token;
  BuildContext context;

  @override
  State<Details_deals> createState() => _Details_dealsState();
}

class _Details_dealsState extends State<Details_deals> {
  double? percentage;
  double? price;
  double? priceAfterDiscount;

  int? value = 0;
  var isFavourite = false;
  DealProvider? dealProvider;

  @override
  void initState() {
    dealProvider = Provider.of<DealProvider>(context, listen: false);
    // getRating();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 2,
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            color: Color(0xFFC0C0CF),
            thickness: 5,
            indent: 120,
            endIndent: 120,
          ),
          SizedBox(
            width: double.maxFinite,
            // height: MediaQuery.of(context).size.height /2,
            child: FutureBuilder<UserSingleDealModel>(
              future:
                  dealProvider!.singleDealDetails(widget.token, widget.dealId!),
              builder: ((context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  var data = snapshot.data!.data!;

                  children = [
                    SizedBox(
                      width: double.infinity,
                      // height: 250,
                      child: Stack(
                        children: [
                          data.images == null || data.images!.isEmpty
                              ? Image.asset(
                                  'assets/images/detail.png',
                                  height: 248,
                                  width: MediaQuery.of(context).size.width,
                                )
                              : Image.network(
                                  '${ApiUrls.imgBaseUrl}${data.images![0].path!}/${data.images![0].image}',
                                  height: 248,
                                  width: MediaQuery.of(context).size.width,
                                ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: const EdgeInsets.only(right: 12, top: 8),
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: IconButton(
                                icon: Icon(
                                  isFavourite == false
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: isFavourite == false
                                      ? Colors.black
                                      : Colors.red,
                                  size: 20,
                                ),
                                onPressed: () {
                                  if (isFavourite) {
                                    Provider.of<DealProvider>(context,
                                            listen: false)
                                        .removeFromWishList(
                                            widget.dealId!, widget.token)
                                        .whenComplete(() {
                                      setState(() {
                                        isFavourite = false;
                                      });
                                    });
                                  } else {
                                    Provider.of<DealProvider>(context,
                                            listen: false)
                                        .wishList(widget.token, {
                                      "deals[0]": widget.dealId,
                                    }).whenComplete(() {
                                      setState(() {
                                        isFavourite = true;
                                      });
                                    });
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    bottom_detail(
                      token: widget.token,
                      // totalReviews: Reviews().getRating(rating!.data),
                      // length: rating!.data!.length.toString(),
                      dealData: data,
                      price: dealProvider!.calculateDiscount(
                          data.discount.toString(),
                          data.price!.toStringAsFixed(0)),
                    ),
                    // const Spacer(),
                    const Divider(
                      color: Color(0xFFC0C0CF),
                      thickness: 1,
                      indent: 24,
                      endIndent: 24,
                    ),
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = <Widget>[
                    Loader(),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ];
                }
                return Column(
                  children: children,
                );
              }),
            ),
          ),
          //cart container
          Container(
            width: double.infinity,
            height: 86,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE6E6E6), width: 1)),
            child: Consumer<Cart>(
              builder: ((context, value, child) {
                return FutureBuilder(
                  future: dealProvider!.getCartItemsList(widget.token),
                  builder: (BuildContext context,
                      AsyncSnapshot<CartListModel> snapshot) {
                    if (snapshot.data == null || snapshot.data!.data!.isEmpty) {
                      return Container(
                        height: 52,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFF5F5F5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 200,
                              height: 54,
                              decoration: BoxDecoration(
                                  color: AppColors.APP_PRIMARY_COLOR,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    if (dealProvider!
                                            .dealModel.data!.dealIsExpired ==
                                        0) {
                                      value.addTCart(
                                          id: dealProvider!.dealModel.data!.id
                                              .toString(),
                                          merchantId: dealProvider!
                                              .dealModel.data!.merchantId
                                              .toString(),
                                          price: dealProvider!.dealModel.data!.price!
                                              .toStringAsFixed(0),
                                          discountOnPrice: dealProvider!
                                              .dealModel.data!.discount!
                                              .toString(),
                                          title: dealProvider!
                                              .dealModel.data!.name!,
                                          reviews: '0',
                                          image: dealProvider!.dealModel.data!.images == null || dealProvider!.dealModel.data!.images!.isEmpty
                                              ? ''
                                              : dealProvider!.dealModel.data!
                                                  .images![0].image!,
                                          reviewsCount: '0',
                                          path: dealProvider!.dealModel.data!.images == null ||
                                                  dealProvider!.dealModel.data!.images!.isEmpty
                                              ? ''
                                              : dealProvider!.dealModel.data!.images![0].path!);
                                      value.checkIsAddedToCart(context);
                                    } else {
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   const SnackBar(
                                      //     content: Text('Deal is expired'),
                                      //   ),
                                      // );
                                      ToastUtil.showToast(
                                          context, 'Deal is expired');
                                    }
                                  },
                                  child: const Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                        fontFamily: 'Mulish',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFFFFFFF)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      log('snapshot : ${snapshot.data!.data!.isNotEmpty}');

                      String name = dealProvider!.dealModel.data!.name!;
                      final list = snapshot.data!.data;
                      bool isPurchased = false;

                      for (int i = 0; i < list!.length; i++) {
                        if (list[i].id == dealProvider!.dealData.id ||
                            list[i].name == name) {
                          isPurchased = true;
                          break;
                        }
                      }
                      log(isPurchased.toString());
                      return isPurchased == true
                          ? const Center(
                              child: Text('You can get a deal once'),
                            )
                          : Container(
                              height: 52,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF5F5F5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Container(
                                  //   width: 117,
                                  //   height: 52,
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //       color: const Color(0xFFF5F5F5)),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //     children: [
                                  // InkWell(
                                  //     onTap: value.qty <= 0
                                  //         ? null
                                  //         : () => value.decreaseQty(),
                                  //     child: const Icon(
                                  //       Icons.remove,
                                  //       color: Colors.white,
                                  //       size: 20,
                                  //     )),
                                  //       Container(
                                  //         margin: const EdgeInsets.symmetric(
                                  //             horizontal: 3),
                                  //         padding: const EdgeInsets.symmetric(
                                  //             horizontal: 3, vertical: 2),
                                  //         decoration: BoxDecoration(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(3),
                                  //             color: const Color(0xFFF5F5F5)),
                                  //         child: Text(
                                  //           value.qty.toString(),
                                  //           style: const TextStyle(
                                  //               color: Colors.black,
                                  //               fontSize: 22),
                                  //         ),
                                  //       ),
                                  //       InkWell(
                                  //           onTap: () => value.increaseQty(),
                                  //           child: const Icon(
                                  //             Icons.add,
                                  //             size: 20,
                                  //           )),
                                  //     ],
                                  //   ),
                                  // ),
                                  Container(
                                    width: 200,
                                    height: 54,
                                    decoration: BoxDecoration(
                                        color: AppColors.APP_PRIMARY_COLOR,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: InkWell(
                                        onTap:
                                            // value.qty <= 0
                                            //     ? () {
                                            //         ScaffoldMessenger.of(context)
                                            //             .showSnackBar(const SnackBar(
                                            //                 content: Text(
                                            //                     'Please add at least one quantity')));
                                            //       }
                                            // :
                                            () {
                                          if (dealProvider!
                                                  .dealData.dealIsExpired ==
                                              0) {
                                            value.addTCart(
                                              id: dealProvider!.dealData.id
                                                  .toString(),
                                              merchantId: dealProvider!
                                                  .dealData.merchantId
                                                  .toString(),
                                              price: dealProvider!
                                                  .dealData.price!
                                                  .toStringAsFixed(0),
                                              discountOnPrice: dealProvider!
                                                  .dealData.discountOnPrice!
                                                  .toString(),
                                              title:
                                                  dealProvider!.dealData.name!,
                                              reviews: '0',
                                              image: dealProvider!.dealData
                                                              .images ==
                                                          null ||
                                                      dealProvider!.dealData
                                                          .images!.isEmpty
                                                  ? ''
                                                  : dealProvider!.dealData
                                                      .images![0].image!,
                                              reviewsCount: '0',
                                              path: dealProvider!.dealData
                                                              .images ==
                                                          null ||
                                                      dealProvider!.dealData
                                                          .images!.isEmpty
                                                  ? ''
                                                  : dealProvider!.dealData
                                                      .images![0].path!,
                                            );
                                            value.checkIsAddedToCart(context);
                                          } else {
                                            // ScaffoldMessenger.of(widget.context).showSnackBar(
                                            //   const SnackBar(
                                            //     content: Text('Deal is expired'),
                                            //   ),
                                            // );
                                            ToastUtil.showToast(
                                                context, 'Deal is expired');
                                          }
                                        },
                                        child: const Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFFFFFFF)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return Loader();
                    }
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ReviewsModel? rating;
  // Future<void> getRating() async {
  //   final result = await Provider.of<DealProvider>(context, listen: false)
  //       .getDealRating(widget.token, widget.dealId.toString());

  //   setState(() {
  //     rating = result;
  //   });
  // }
}
