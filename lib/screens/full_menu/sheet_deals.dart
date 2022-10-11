import 'package:flutter/material.dart';
import 'package:SiBuy/apis/api_urls.dart';
import 'package:SiBuy/models/merchant_single_deal.dart';
import 'package:SiBuy/services/deals/merchant_deal_services.dart';
import 'package:provider/provider.dart';

import '../../models/reviews_model.dart';
import '../../providers/deal_provider.dart';

class sheet_deals extends StatefulWidget {
  const sheet_deals({Key? key, required this.dealId, required this.token})
      : super(key: key);
  final String? dealId;
  final String token;

  @override
  State<sheet_deals> createState() => _sheet_dealsState();
}

class _sheet_dealsState extends State<sheet_deals> {
  String? totalReviews = '0';
  int? value = 0;
  var isLaoding = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getRating();
    // totalReviews = Reviews().getRating(widget.data!.reviews!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Divider(
            color: Color(0xFFC0C0CF),
            thickness: 5,
            indent: 120,
            endIndent: 120,
          ),
          Expanded(
            child: FutureBuilder<MerchantSingleDeal>(
              future: DealServices().getSingleDeal(
                  dealId: widget.dealId.toString(), token: widget.token),
              builder: (context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  var data = snapshot.data!.data!;
                  children = [
                    data.images!.isEmpty
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 4),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 4),
                        child: Text(
                          data.name ?? 'no name provided',
                          style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4A4A6A)),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 4),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/menu_location.png',
                              width: 8,
                              height: 8,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 60,
                              child: Text(
                                data.branches![0].address ?? 'no addres found',
                                style: const TextStyle(
                                    fontFamily: 'Mulish',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF8E8EA9)),
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 4),
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
                                  color: Color(0xFF5F5F5F)),
                            ),
                            Text(
                              '(${rating == null || rating!.data!.isEmpty ? '0' : rating!.data!.length.toString()} reviews)',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 4,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF5F5F5F)),
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 4),
                        child: Row(
                          children: [
                            const Text(
                              '\$',
                              style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFF6767)),
                            ),
                            Text(
                              data.price.toStringAsFixed(2),
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontFamily: 'Mulish',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFF6767)),
                            ),
                            const Text(
                              '\$',
                              style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFff6600)),
                            ),
                            Text(
                              Provider.of<DealProvider>(context, listen: false)
                                  .calculateDiscount(
                                      data.discountOnPrice!.toString(),
                                      data.price!.toStringAsFixed(0)),
                              style: const TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFff6600)),
                            ),
                            Container(
                              width: 50,
                              height: 25,
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                              child: Center(
                                child: Text(
                                  '${data.discountOnPrice ?? 0}% OFF',
                                  style: const TextStyle(
                                      fontSize: 8,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFFff6600)),
                                ),
                              ),
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 4),
                      child: Text(
                        'Discount type : ${data.type ?? 'not specified'}',
                        style: const TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFff6600)),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF8E8EA9)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 4),
                      child: Text(
                        data.description ?? 'no description provided',
                        style: const TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF8E8EA9)),
                      ),
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
                    Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Center(child: Text('Awaiting result...')),
                    )
                  ];
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  ReviewsModel? rating;
  Future<void> getRating() async {
    final result = await Provider.of<DealProvider>(context, listen: false)
        .getDealRating(widget.token, widget.dealId!);
    setState(() {
      rating = result;
    });
  }
}
