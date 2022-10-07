import 'package:flutter/material.dart';
import 'package:gigi_app/apis/api_urls.dart';
import 'package:gigi_app/models/puchase_model.dart';
import 'package:gigi_app/providers/deal_provider.dart';
import 'package:gigi_app/services/deals/user_deals_services.dart';
import 'package:gigi_app/services/reviews_services.dart';
import 'package:gigi_app/shared/custom_button.dart';
import 'package:provider/provider.dart';

class review extends StatefulWidget {
  const review({Key? key, required this.token, required this.dealId})
      : super(key: key);
  final String token;
  final String dealId;

  @override
  State<review> createState() => _reviewState();
}

class _reviewState extends State<review> {
  final ctr = TextEditingController();
  SinglePurchaseModel? singlePurchaseModel;

  Future<void> getData() async {
    final result =
        await UserDealServices().purchaseDetails(widget.token, widget.dealId);
    setState(() {
      singlePurchaseModel = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: const EdgeInsets.only(right: 24, left: 24),
              child: singlePurchaseModel == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(
                          color: Color(0xFFC0C0CF),
                          thickness: 5,
                          indent: 120,
                          endIndent: 120,
                        ),
                        const SizedBox(height: 5),
                        singlePurchaseModel!.data!.image == null ||
                                singlePurchaseModel!.data!.image!.image!.isEmpty
                            ? Image.asset('assets/images/detail.png')
                            : Image.network(
                                '${ApiUrls.imgBaseUrl}/${singlePurchaseModel!.data!.image!.path}/${singlePurchaseModel!.data!.image!.image}'),
                        const SizedBox(height: 12),
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
                            child: Text(
                              singlePurchaseModel!.data!.name!,
                              style: const TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4A4A6A)),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
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
                                      color: Color(0xFFFF6767)),
                                ),
                                Text(
                                  singlePurchaseModel!.data!.price!.toString(),
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontFamily: 'Mulish',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffff6767f)),
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
                                  Provider.of<DealProvider>(context)
                                      .calculateDiscount(
                                          singlePurchaseModel!
                                              .data!.discountOnPrice!
                                              .toString(),
                                          singlePurchaseModel!.data!.price!
                                              .toString()),
                                  style: const TextStyle(
                                      fontFamily: 'Mulish',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFff6600)),
                                ),
                              ],
                            )),
                        const SizedBox(height: 12),
                        const Text('Coupons Left:  100/100',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 7,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF8E8EA9))),
                        const SizedBox(height: 5),
                        const Text('Description',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF8E8EA9))),
                        const SizedBox(height: 5),
                        Text(
                            singlePurchaseModel!.data!.description ??
                                'no description provided',
                            style: const TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF8E8EA9))),
                        const SizedBox(height: 12),
                        const Text(
                          'Review the Offer',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF4A4A6A)),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Image.asset('assets/images/rate.png',
                                width: 18, height: 18),
                            Image.asset('assets/images/rate.png',
                                width: 18, height: 18),
                            Image.asset('assets/images/rate.png',
                                width: 18, height: 18),
                            Image.asset('assets/images/rate.png',
                                width: 18, height: 18),
                            Image.asset('assets/images/rate.png',
                                width: 18, height: 18),
                          ],
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: TextEditingController(),
                          autofocus: true,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: 'Write a Review..',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        CustomButton(
                            text: 'Submit',
                            onPressed: () {
                              ReviewsServices()
                                  .writeReview(widget.token, {
                                    'merchant_id': singlePurchaseModel!
                                        .data!.merchantId
                                        .toString(),
                                    'rating': '4',
                                    'deal_id': singlePurchaseModel!.data!.id
                                        .toString(),
                                    'notes': ctr.text,
                                  })
                                  .then(
                                    (value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text('adding a review'),
                                      ),
                                    ),
                                  )
                                  .whenComplete(
                                    () => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text('Review add to the deal'),
                                      ),
                                    ),
                                  );
                            })
                      ],
                    )),
        ),
      ),
    );
  }
}
