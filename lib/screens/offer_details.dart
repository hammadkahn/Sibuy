import 'package:flutter/material.dart';
import 'package:SiBuy/models/deal_model.dart';
import 'package:provider/provider.dart';

import '../apis/api_urls.dart';
import '../providers/deal_provider.dart';

class OfferDetails extends StatefulWidget {
  const OfferDetails({Key? key, required this.data}) : super(key: key);
  final MerchantListDealData data;

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  int? value = 0;
  var isLaoding = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // totalReviews = Reviews().getRating(widget.data!.reviews!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.name ?? 'Details'),
        backgroundColor: const Color(0xFFff6600),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child:
                  widget.data.image == null || widget.data.image!.image!.isEmpty
                      ? Image.asset(
                          'assets/images/detail.png',
                          height: 248,
                          width: MediaQuery.of(context).size.width,
                        )
                      : Image.network(
                          '${ApiUrls.imgBaseUrl}${widget.data.image!.path!}/${widget.data.image!.image}',
                          height: 248,
                          width: MediaQuery.of(context).size.width,
                        ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4),
                child: ListTile(
                  title: Text(
                    widget.data.name ?? 'no name',
                    style: const TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A4A6A)),
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/menu_location.png',
                            width: 8,
                            height: 8,
                          ),
                          const Text(
                            'Cafe Bistrovia - Baku, Azerbaijan',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF8E8EA9)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset('assets/images/rating.png',
                              width: 10, height: 10),
                          Text(
                            '${widget.data.reviewAndCount ?? 0}',
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF5F5F5F)),
                          ),
                          Text(
                            '(${widget.data.reviewAndCount ?? 0} reviews)',
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF5F5F5F)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 2.0,
                        indent: 10.0,
                        endIndent: 10.0,
                      ),
                    ],
                  ),
                )),
            Container(
              color: Color(0xFFE0E0E0), // light grey color

              child: ListTile(
                title: Row(
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
                      '${widget.data.price ?? 0}',
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFF6767)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    const Text(
                      '\$',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0D9BFF)),
                    ),
                    Text(
                      Provider.of<DealProvider>(context, listen: false)
                          .calculateDiscount(
                              widget.data.discountOnPrice!.toString(),
                              widget.data.price!.toStringAsFixed(0)),
                      style: const TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0D9BFF)),
                    ),
                    Container(
                      width: 28,
                      height: 11,
                      margin: const EdgeInsets.only(left: 12),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                      child: Center(
                        child: Text(
                          '${widget.data.discountOnPrice ?? 0}% OFF',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 9,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0D9BFF)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 2.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            ListTile(
              title: const Text(
                'Description',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                widget.data.description ?? 'no description provided',
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 50, left: 10, top: 10, bottom: 10),
              // add padding on all sides
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey, // grey border
                  width: 2, // border width of 2
                ),
              ),
              child: ListTile(
                  title: const Text(
                    'Deal Reports',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Total Sales: ',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${widget.data.totalPurchase ?? '0'}',
                            style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Total Reviews: ',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${widget.data.reviewAndCount ?? '0'}',
                            style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Total Redeem: ',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${widget.data.totalRadeem ?? '0'}',
                            style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
