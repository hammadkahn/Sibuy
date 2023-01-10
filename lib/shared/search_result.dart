import 'package:flutter/material.dart';
import 'package:SiBuy/models/category_model.dart';
import 'package:provider/provider.dart';

import '../apis/api_urls.dart';
import '../constant/app_styles.dart';
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
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: searchModel!.data!.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Insets.gapH10;
                  },
                  itemBuilder: ((context, index) {
                    var data = searchModel!.data![index];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      width: SizeConfig.screenWidth * 0.85,
                      decoration: const BoxDecoration(
                          color: AppColors.APP_PRIMARY_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(26))),
                            isScrollControlled: true,
                            context: context,
                            builder: (ct) => Wrap(
                              children: [
                                Details_deals(
                                  context: context,
                                  dealId: data.id.toString(),
                                  token: token,
                                ),
                              ],
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  child: Text(
                                    data.name!,
                                    softWrap: true,
                                    style: const TextStyle(
                                        fontFamily: 'Mulish',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFFFFFFF)),
                                  ),
                                ),
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
                                          'Expiry: ',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          searchModel!.data![index].expiry!,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
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
                                            color: Colors.white),
                                      ),
                                      Text(
                                        data.price!.toString(),
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontFamily: 'Mulish',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                      Insets.gapW10,
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
                                                data.discount!.toString(),
                                                data.price!.toString()),
                                        style: const TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                      Insets.gapW5,
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3))),
                                        child: Center(
                                          child: Text(
                                            '${data.discount}% OFF',
                                            style: const TextStyle(
                                                fontSize: 8,
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w900,
                                                color: AppColors
                                                    .APP_PRIMARY_COLOR),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Discount On:  ',
                                      style: const TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                      children: [
                                        TextSpan(
                                          text: data.categoryName.toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              height: 100,
                              width: 120,
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
                    );
                  }),
                ),
        ));
  }
}
