import 'package:flutter/material.dart';
import 'package:SiBuy/models/deal_model.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../apis/api_urls.dart';
import '../../constant/size_constants.dart';
import '../../models/reviews_model.dart';
import 'deals_details.dart';

class dealsUser extends StatefulWidget {
  const dealsUser({Key? key, required this.dealData, required this.token})
      : super(key: key);
  final DealData dealData;
  final String token;

  @override
  State<dealsUser> createState() => _dealsUserState();
}

class _dealsUserState extends State<dealsUser> {
  final key = GlobalKey<ScaffoldState>();
  DealProvider? dealProvider;
  ValueNotifier<bool> isLoaded = ValueNotifier(false);

  @override
  void didChangeDependencies() {
    dealProvider = Provider.of<DealProvider>(context, listen: false);
    if (mounted) {
      dealProvider!
          .singleDealDetails(widget.token, widget.dealData.id.toString())
          .whenComplete(() {
        isLoaded.value = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ValueListenableBuilder(
      valueListenable: isLoaded,
      builder: (BuildContext context, bool value, Widget? child) {
        return isLoaded.value == false
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: 145,
                  decoration: const BoxDecoration(
                      color: Color(0xFFff6600),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(26))),
                        isScrollControlled: true,
                        context: context,
                        builder: (ct) => Scaffold(
                          key: key,
                          extendBody: false,
                          body: SingleChildScrollView(
                            controller: ModalScrollController.of(ct),
                            child: Details_deals(
                              dealId: dealProvider!.dealData.id.toString(),
                              token: widget.token,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 21),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
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
                                    child: Text(
                                      dealProvider!.dealData.name ??
                                          'not specified',
                                      softWrap: true,
                                      style: const TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFFFFFFF)),
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
                                        Expanded(
                                          child: Text(
                                            dealProvider!.dealData.branches![0]
                                                    .address ??
                                                'unknown',
                                            softWrap: true,
                                            style: const TextStyle(
                                                fontFamily: 'Mulish',
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFFFFFFFF)),
                                          ),
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
                                          rating == null ||
                                                  rating!.value!.data!.isEmpty
                                              ? '0'
                                              : Reviews().getRating(
                                                  rating!.value!.data),
                                          // Reviews().getRating(
                                          //     dealProvider!.dealData.reviews),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 7,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFFFFFFFF)),
                                        ),
                                        Text(
                                          '(${rating == null || rating!.value!.data!.isEmpty ? '0' : rating!.value!.data!.length.toString()} reviews)',
                                          // '(${dealProvider!.dealData.reviews!.length} reviews)',
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
                                        '${dealProvider!.dealData.price ?? '0'}',
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
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
                                        dealProvider!.calculateDiscount(
                                          '${dealProvider!.dealData.discountOnPrice ?? '0'}',
                                          dealProvider!.dealData.price!
                                              .toStringAsFixed(0),
                                        ),
                                        style: const TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3))),
                                        child: Center(
                                          child: Text(
                                            '${dealProvider!.dealData.discountOnPrice ?? '0'}% OFF',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xFFff6600)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 80,
                            height: 100,
                            child: widget.dealData.image == null ||
                                    widget.dealData.image!.image!.isEmpty
                                ? Image.asset('assets/images/food.png')
                                : Image.network(
                                    '${ApiUrls.imgBaseUrl}${widget.dealData.image!.path}/${widget.dealData.image!.image}',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  ValueNotifier<ReviewsModel?>? rating = ValueNotifier(ReviewsModel());
  Future<void> getRating() async {
    final result = await Provider.of<DealProvider>(context, listen: false)
        .getDealRating(widget.token, dealProvider!.dealData.id.toString());

    rating!.value = result;
  }
}
