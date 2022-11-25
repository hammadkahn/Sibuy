import 'package:flutter/material.dart';
import 'package:SiBuy/constant/size_constants.dart';
import 'package:SiBuy/models/deal_model.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:provider/provider.dart';

import '../../apis/api_urls.dart';
import '../../models/reviews_model.dart';

class Deals extends StatefulWidget {
  const Deals(
      {Key? key, required this.merchantListOfDeals, required this.token})
      : super(key: key);

  final MerchantListDealData merchantListOfDeals;
  final String token;

  @override
  State<Deals> createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  @override
  void initState() {
    super.initState();
    getRating();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: SizeConfig.screenWidth,
        height: 145,
        decoration: const BoxDecoration(
            color: Color(0xFFff6600),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.only(left: 21),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Offer of the Week',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFA5A5BA)),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: Text(
                          widget.merchantListOfDeals.name!,
                          style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF)),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const Text(
                            'Remaining Qty: ',
                            style: TextStyle(
                              fontSize: 7,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.merchantListOfDeals.remaining.toString(),
                            style: const TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFFFFFF)),
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Image.asset('assets/images/rating.png',
                              width: 6, height: 6),
                          Text(
                            rating == null || rating!.data!.isEmpty
                                ? '0'
                                : Reviews().getRating(rating!.data),
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 7,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF)),
                          ),
                          Text(
                            '(${rating == null || rating!.data!.isEmpty ? '0' : rating!.data!.length.toString()} reviews)',
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 4,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF)),
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 2.83),
                      child: Row(
                        children: [
                          const Text(
                            '\$',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFff6600)),
                          ),
                          Text(
                            widget.merchantListOfDeals.price!.toString(),
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontFamily: 'Mulish',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFff6600)),
                          ),
                          const Text(
                            '\$',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF)),
                          ),
                          Text(
                            Provider.of<DealProvider>(context, listen: false)
                                .calculateDiscount(
                                    widget.merchantListOfDeals.discountOnPrice!
                                        .toString(),
                                    widget.merchantListOfDeals.price!
                                        .toStringAsFixed(0)),
                            style: const TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF)),
                          ),
                          Container(
                            width: 28,
                            height: 11,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                            child: Center(
                              child: Text(
                                '${widget.merchantListOfDeals.discountOnPrice} % OFF',
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFFff6600)),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
              const Spacer(),
              Container(
                height: 120,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: widget.merchantListOfDeals.image == null
                    ? Image.asset(
                        'assets/images/food.png',
                        fit: BoxFit.cover,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${ApiUrls.imgBaseUrl}/${widget.merchantListOfDeals.image!.path}/${widget.merchantListOfDeals.image!.image}',
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ReviewsModel? rating;
  Future<void> getRating() async {
    final result = await Provider.of<DealProvider>(context, listen: false)
        .getDealRating(widget.token, widget.merchantListOfDeals.id.toString());
    setState(() {
      rating = result;
    });
  }
}
