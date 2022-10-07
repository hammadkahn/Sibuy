import 'package:flutter/material.dart';
import 'package:gigi_app/models/cart_model.dart';
import 'package:gigi_app/models/deal_model.dart';
import 'package:gigi_app/providers/deal_provider.dart';
import 'package:provider/provider.dart';

import '../../models/reviews_model.dart';
import '../../providers/order.dart';
import 'details_bottom.dart';

class Details_deals extends StatefulWidget {
  const Details_deals({Key? key, this.dealId, required this.token})
      : super(key: key);
  final String? dealId;
  final String token;

  @override
  State<Details_deals> createState() => _Details_dealsState();
}

class _Details_dealsState extends State<Details_deals> {
  static const baseUrl = 'http://gigi-api.cryslistechnologies.com/';
  double? percentage;
  double? price;
  double? priceAfterDiscount;

  int? value = 0;
  var isLaoding = false;
  DealProvider? dealProvider;

  @override
  void initState() {
    dealProvider = Provider.of<DealProvider>(context, listen: false);
    getRating();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            color: Color(0xFFC0C0CF),
            thickness: 5,
            indent: 120,
            endIndent: 120,
          ),
          SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height - 200,
            child: FutureBuilder<SingleDeal>(
              future:
                  dealProvider!.singleDealDetails(widget.token, widget.dealId!),
              builder: ((context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  var data = snapshot.data!.data!;

                  children = [
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: Stack(
                        children: [
                          data.images == null || data.images!.isEmpty
                              ? Image.asset(
                                  'assets/images/detail.png',
                                  height: 248,
                                  width: MediaQuery.of(context).size.width,
                                )
                              : Image.network(
                                  '$baseUrl${data.images![0].path!}/${data.images![0].image}',
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
                                  isLaoding == false
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: isLaoding == false
                                      ? Colors.black
                                      : Colors.red,
                                  size: 20,
                                ),
                                onPressed: () {
                                  Provider.of<DealProvider>(context,
                                          listen: false)
                                      .wishList(widget.token, {
                                    "deals[0]":
                                        dealProvider!.dealData.id.toString()
                                  }).whenComplete(() {
                                    setState(() {
                                      isLaoding = true;
                                    });
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    rating == null
                        ? const Center(child: CircularProgressIndicator())
                        : bottom_detail(
                            token: widget.token,
                            totalReviews: Reviews().getRating(rating!.data),
                            length: rating!.data!.length.toString(),
                            dealData: data,
                            price: dealProvider!.calculateDiscount(
                                data.discountOnPrice.toString(),
                                data.price!.toStringAsFixed(0)),
                          ),
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
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ];
                }
                return SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height - 100,
                  child: Column(
                    children: children,
                  ),
                );
              }),
            ),
          ),
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
                    if (snapshot.hasData) {
                      String name = dealProvider!.dealData.name!;
                      final list = snapshot.data!.data;
                      bool isPurchased = false;
                      for (int i = 0; i < list!.length; i++) {
                        if (list[i].id == dealProvider!.dealData.id ||
                            list[i].name == name) {
                          isPurchased = true;
                          break;
                        }
                      }

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
                                        color: const Color(0xFFff6600),
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
                                                title: dealProvider!
                                                    .dealData.name!,
                                                reviews: '0',
                                                image: dealProvider!.dealData.images == null || dealProvider!.dealData.images!.isEmpty
                                                    ? ''
                                                    : dealProvider!.dealData
                                                        .images![0].image!,
                                                reviewsCount: '0',
                                                path: dealProvider!.dealData.images == null ||
                                                        dealProvider!.dealData.images!.isEmpty
                                                    ? ''
                                                    : dealProvider!.dealData.images![0].path!);
                                            value.checkIsAddedToCart(context);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('Deal is expired'),
                                              ),
                                            );
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
                      return const Center(child: CircularProgressIndicator());
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

  ReviewsModel? rating;
  Future<void> getRating() async {
    final result = await Provider.of<DealProvider>(context, listen: false)
        .getDealRating(widget.token, widget.dealId.toString());

    setState(() {
      rating = result;
    });
  }
}
