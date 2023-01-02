import 'package:flutter/material.dart';
import 'package:SiBuy/models/merchant_model.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:SiBuy/services/user_merchant_services.dart';
import 'package:provider/provider.dart';
import '../../apis/api_urls.dart';
import '../../constant/app_styles.dart';
import '../../constant/color_constant.dart';
import '../../shared/loader.dart';

class StoreProfile extends StatelessWidget {
  const StoreProfile({Key? key, required this.profileId, required this.token})
      : super(key: key);
  final String profileId;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0xffFCFCFC),
            Color(0xffF7F7F7),
            Color(0xffF7F7F7),
            Color(0xffF7F7F7),
            Color(0xffFCFCFC)
          ])),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 51, right: 29, left: 29),
            child: SingleChildScrollView(
              child: FutureBuilder<SingleMerchant>(
                future: UserMerchantServices()
                    .singleMerchantProfile(id: profileId, token: token),
                builder: ((context, snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    var data = snapshot.data!.data!;
                    if (data.statusName != 'Active') {
                      children = [
                        Center(
                          child: Text(
                              '${snapshot.data!.data!.name} is not active'),
                        ),
                      ];
                    } else {
                      children = [
                        data.profilePicture == null
                            ? Image.asset('assets/images/slt.png')
                            : Image.network(
                                '${ApiUrls.imgBaseUrl}/${data.profilePicturePath}/${data.profilePicture}'),
                        Padding(
                          padding: const EdgeInsets.only(top: 13, bottom: 10),
                          child: Text(data.name!,
                              style: const TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff000000))),
                        ),
                        Text(
                          data.branches == null || data.branches!.isEmpty
                              ? 'merchant have no branch'
                              : data.branches![0].address ?? 'no address found',
                          style: const TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.APP_PRIMARY_COLOR),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${data.phone ?? 'not povided'} - ${data.email}',
                          style: const TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         '${data.averageRating.toStringAsFixed(2) ?? 0}',
                        //         style: const TextStyle(
                        //             fontSize: 30, color: AppColors.APP_PRIMARY_COLOR),
                        //         textAlign: TextAlign.center,
                        //       ),
                        //       const SizedBox(width: 5),
                        //       Column(
                        //         children: [
                        //           Row(
                        //             children: [
                        //               Image.asset('assets/images/rate.png',
                        //                   width: 18, height: 18),
                        //               Image.asset('assets/images/rate.png',
                        //                   width: 18, height: 18),
                        //               Image.asset('assets/images/rate.png',
                        //                   width: 18, height: 18),
                        //               Image.asset('assets/images/rate.png',
                        //                   width: 18, height: 18),
                        //               Image.asset('assets/images/rate.png',
                        //                   width: 18, height: 18),
                        //             ],
                        //           ),
                        //           const Text(
                        //             'Reviews and Rating',
                        //             style: TextStyle(
                        //               fontFamily: 'DMSans',
                        //               fontSize: 10,
                        //               fontWeight: FontWeight.w500,
                        //               color: Color(0xff000000),
                        //             ),
                        //             textAlign: TextAlign.center,
                        //           ),
                        //         ],
                        //       )
                        //     ]),
                        Insets.gapH10,
                        // Container(
                        //   height: 30,
                        //   width: 70,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       color: AppColors.APP_PRIMARY_COLOR),
                        //   child: const Center(
                        //     child: Text('View',
                        //         style: TextStyle(
                        //             fontFamily: 'DMSans',
                        //             fontSize: 20,
                        //             fontWeight: FontWeight.w500,
                        //             color: Color(0xffFCFCFC))),
                        //   ),
                        // ),
                        // const SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('48',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.APP_PRIMARY_COLOR)),
                              Text('|'),
                              Text('400+',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.APP_PRIMARY_COLOR)),
                              Text('|'),
                              Text('2',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.APP_PRIMARY_COLOR)),
                            ]),
                        const SizedBox(height: 20),
                        // const Text('Reviews',
                        //     style: TextStyle(
                        //         fontFamily: 'DMSans',
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w500,
                        //         color: Color(0xff000000))),
                        // Insets.gapH10,
                        // // Row(
                        // //   mainAxisAlignment: MainAxisAlignment.center,
                        // //   children: [
                        // //     Image.asset('assets/images/rate.png',
                        // //         width: 15, height: 15),
                        // //     Image.asset('assets/images/rate.png',
                        // //         width: 15, height: 15),
                        // //     Image.asset('assets/images/rate.png',
                        // //         width: 15, height: 15),
                        // //     Image.asset('assets/images/rate.png',
                        // //         width: 15, height: 15),
                        // //     Image.asset('assets/images/rate.png',
                        // //         width: 15, height: 15),
                        // //     const SizedBox(
                        // //       width: 20,
                        // //     ),
                        // //     Text('${data.reviews!.length} Reviews',
                        // //         style: const TextStyle(
                        // //             fontFamily: 'DMSans',
                        // //             fontSize: 10,
                        // //             fontWeight: FontWeight.w500,
                        // //             color: Color(0xff898989)))
                        // //   ],
                        // // ),
                        // data.reviews == null || data.reviews!.isEmpty
                        //     ? const Center(child: Text('Not reviewed yet'))
                        //     : SizedBox(
                        //         width: double.infinity,
                        //         height:
                        //             MediaQuery.of(context).size.height * 0.75,
                        //         child: ListView.builder(
                        //             itemCount: data.reviews!.length,
                        //             shrinkWrap: true,
                        //             itemBuilder: (context, index) {
                        //               return ListTile(
                        //                 title: Text(
                        //                   data.reviews![index].notes == null
                        //                       ? 'no notes written'
                        //                       : data.reviews![index].notes ??
                        //                           '',
                        //                 ),
                        //                 subtitle: Text(
                        //                   data.reviews![index].userName ??
                        //                       'no name',
                        //                 ),
                        //                 trailing: SizedBox(
                        //                   width: 75,
                        //                   child: Row(
                        //                     children:
                        //                         Provider.of<DealProvider>(
                        //                                 context,
                        //                                 listen: false)
                        //                             .getStars(
                        //                       int.parse(data
                        //                           .reviews![index].rating!
                        //                           .toString()),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               );
                        //               // return user_review(
                        //               //   review: data.reviews![index].notes == null
                        //               //       ? ''
                        //               //       : data.reviews![index].notes ?? '',
                        //               //   reviewSender:
                        //               //       data.reviews![index].userName ??
                        //               //           'no name',
                        //               // );
                        //             }),
                        //       )
                      ];
                    }
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
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        ),
                      )
                    ];
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: children,
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
