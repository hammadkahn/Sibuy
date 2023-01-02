import 'package:SiBuy/models/dashbaord_stats_model.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/models/deal_model.dart';
import 'package:SiBuy/screens/full_menu/location_bar.dart';
import 'package:SiBuy/services/dashboard_stats/dash_board.dart';
import 'package:SiBuy/services/deals/merchant_deal_services.dart';
import '../../constant/app_styles.dart';
import '../../shared/loader.dart';
import '../../constant/size_constants.dart';
import '../../user_app/user_menu/demi_deals.dart';
import 'percent_ind2.dart';
import 'percent_ind3.dart';
import 'percent_indicator.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.only(top: 27, left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                location_bar(
                  token: token,
                ),
                Insets.gapH10,
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 550 / 812,
                  child: FutureBuilder<DashboardStatsModel>(
                    future: DashBoardStats().getDashBoardStats(token),
                    builder: (context, snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        children = [
                          Dashboard(
                            totalSale:
                                snapshot.data!.data!.totalSales.toString(),
                          ),
                          const SizedBox(height: 8),
                          Stacked_container(
                            discountAvailed: snapshot
                                .data!.data!.totalCouponRadeemed
                                .toString(),
                          ),
                          const SizedBox(height: 8),
                          Stacked_container2(
                            title: 'Total Active Deals',
                            totalActiveDeals: snapshot
                                .data!.data!.totalActiveOffers
                                .toString(),
                            iicons: 'vouch',
                          ),
                          const SizedBox(height: 8),
                          Stacked_container2(
                            title: 'Total Deal Sale',
                            totalActiveDeals:
                                snapshot.data!.data!.totalDealSale.toString(),
                            iicons: 'vouch1',
                          ),
                          const SizedBox(height: 8),
                          Stacked_container2(
                            title: 'Total Unredeemed Withholding',
                            totalActiveDeals: snapshot
                                .data!.data!.totalUnredeemedWithHolding
                                .toString(),
                            iicons: 'vouch2',
                          ),
                          const SizedBox(height: 8),
                          Stacked_container2(
                            title: 'Total Transaction Fee',
                            totalActiveDeals: snapshot
                                .data!.data!.totalTransactionFee
                                .toString(),
                            iicons: 'vouch3',
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
                        children = <Widget>[
                          Loader(),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...'),
                          )
                        ];
                      }
                      return Column(children: children);
                    },
                  ),
                ),
                SizedBox(
                  // height: MediaQuery.of(context).size.height / 1,
                  child: FutureBuilder<MerchantDealListModel>(
                    future: DealServices().getAllDeals(token: token),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Loader();
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.data!.data!.isEmpty) {
                            return Column(
                              children: const [
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            );
                            // const Center(
                            //     child: Text('No deals available'));
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.data!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = snapshot.data!.data![index];
                                return InkWell(
                                  onTap: () {
                                    print(data.id);
                                    // showModalBottomSheet(
                                    //     isScrollControlled: true,
                                    //     context: context,
                                    //     builder: (context) => sheet_deals(
                                    //           dealId: data.id.toString(),
                                    //           token: token,
                                    //         ));
                                  },
                                  child: Demo_Deals(
                                    token: token,
                                    data: data,
                                  ),
                                );
                              },
                            );
                          }
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 20 / 812,
                )
              ],
            ),
          ),
        ));
  }

  // Map<String, dynamic>? dashBoardModel;

  // Future<void> getDashData() async {
  //   final result = await DashBoardStats().getDashBoardStats(token);
  //   setState(() {
  //     dashBoardModel = result;
  //   });
  //   print(result['responseCode']);
  // }
}
