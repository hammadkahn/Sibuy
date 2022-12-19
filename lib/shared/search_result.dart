import 'package:flutter/material.dart';
import 'package:SiBuy/models/category_model.dart';
import 'package:provider/provider.dart';

import '../apis/api_urls.dart';
import '../constant/color_constant.dart';
import '../constant/size_constants.dart';
import '../providers/deal_provider.dart';
import '../user_app/user_menu/deals_details.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, required this.searchModel, required this.token})
      : super(key: key);
  final SearchModel? searchModel;
  final String token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.APP_PRIMARY_COLOR,
          title: const Text('Search Result'),
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: searchModel == null || searchModel!.data!.isEmpty
              ? const Center(
                  child: Text(
                    'Not deals found in your area',
                    textScaleFactor: 1.1,
                  ),
                )
              : ListView.builder(
                  itemCount: searchModel!.data!.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    var data = searchModel!.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        width: SizeConfig.screenWidth,
                        height: 145,
                        decoration: const BoxDecoration(
                            color: AppColors.APP_PRIMARY_COLOR,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 21),
                          child: InkWell(
                            onTap: () => showModalBottomSheet(
                                // isScrollControlled: true,
                                context: context,
                                builder: (context) => Details_deals(
                                  context: context,
                                      dealId: data.id.toString(),
                                      token: token,
                                    )),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              180,
                                          child: Text(
                                            data.name!,
                                            softWrap: true,
                                            style: const TextStyle(
                                                fontFamily: 'Mulish',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFFFFFFFF)),
                                          ),
                                        )),
                                    // Padding(
                                    //     padding: const EdgeInsets.only(top: 4),
                                    //     child: Row(
                                    //       children: [
                                    //         Image.asset(
                                    //           'assets/images/menu_location.png',
                                    //           width: 8,
                                    //           height: 8,
                                    //         ),
                                    //         const Text(
                                    //           'Cafe Bistrovia - Baku, Azerbaijan',
                                    //           style: TextStyle(
                                    //               fontFamily: 'Mulish',
                                    //               fontSize: 10,
                                    //               fontWeight: FontWeight.w600,
                                    //               color: Color(0xFFFFFFFF)),
                                    //         ),
                                    //       ],
                                    //     )),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Expiry:',
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              searchModel!.data![index].expiry!,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.APP_PRIMARY_COLOR),
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
                                                color: AppColors.APP_PRIMARY_COLOR),
                                          ),
                                          Text(
                                            data.price!.toString(),
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontFamily: 'Mulish',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.APP_PRIMARY_COLOR),
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
                                            Provider.of<DealProvider>(context,
                                                    listen: false)
                                                .calculateDiscount(
                                                    data.discountOnPrice!
                                                        .toString(),
                                                    data.price!.toString()),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3))),
                                            child: Center(
                                              child: Text(
                                                '${data.discountOnPrice} % OFF',
                                                style: const TextStyle(
                                                    fontSize: 5,
                                                    fontFamily: 'Mulish',
                                                    fontWeight: FontWeight.w900,
                                                    color: AppColors.APP_PRIMARY_COLOR),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: 'Discount On:',
                                          style: const TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                          children: [
                                            TextSpan(
                                              text: data.type.toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'Mulish',
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.APP_PRIMARY_COLOR),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  height: 120,
                                  width: 135,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: data.image == null
                                      ? Image.asset(
                                          'assets/images/food.png',
                                          fit: BoxFit.cover,
                                        )
                                      : CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            '${ApiUrls.imgBaseUrl}${data.image!.path}/${data.image!.image}',
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
        ));
  }
}
