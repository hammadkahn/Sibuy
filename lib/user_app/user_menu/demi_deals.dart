import 'package:SiBuy/models/deal_model.dart';
import 'package:SiBuy/screens/offer_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../apis/api_urls.dart';
import '../../constant/size_constants.dart';
import '../../providers/deal_provider.dart';

class Demo_Deals extends StatelessWidget {
  const Demo_Deals({Key? key, this.data, this.token}) : super(key: key);
  final MerchantListDealData? data;
  final String? token;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OfferDetails(data: data!),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
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
                        child: Text(
                          data!.name ?? 'Avocado Chicken \nSalad',
                          style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF)),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          data!.categoryName ??
                              'Cafe Bistrovia - Baku, Azerbaijan',
                          style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF)),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            Image.asset('assets/images/rating.png',
                                width: 6, height: 6),
                            Text(
                              data!.reviewAndCount.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 7,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFFFFFF)),
                            ),
                            // const Text(
                            //   '(30 reviews)',
                            //   style: TextStyle(
                            //       fontFamily: 'Poppins',
                            //       fontSize: 4,
                            //       fontWeight: FontWeight.w400,
                            //       color: Color(0xFFFFFFFF)),
                            // ),
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
                                  color: Color(0xFF0D9BFF)),
                            ),
                            Text(
                              data!.price!.toStringAsFixed(2),
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontFamily: 'Mulish',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF0D9BFF)),
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
                                  .calculateDiscount(data!.discount!.toString(),
                                      data!.price!.toStringAsFixed(0)),
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
                                  '${data!.discountOnPrice ?? 20}% OFF',
                                  style: const TextStyle(
                                      fontSize: 5,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF0D9BFF)),
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
                const Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height * 150 / 812,
                  // width: MediaQuery.of(context).size.width * 150 / 400,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: data!.image == null
                      ? Image.asset(
                          'assets/images/food.png',
                          fit: BoxFit.cover,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${ApiUrls.imgBaseUrl}/${data!.image!.path}/${data!.image!.image}',
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
