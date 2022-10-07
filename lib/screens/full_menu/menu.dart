import 'package:flutter/material.dart';
import 'package:gigi_app/models/deal_model.dart';
import 'package:gigi_app/screens/full_menu/location_bar.dart';
import 'package:gigi_app/screens/full_menu/sheet_deals.dart';
import 'package:gigi_app/services/dashboard_stats/dash_board.dart';
import 'package:gigi_app/services/deals/merchant_deal_services.dart';

import '../../constant/size_constants.dart';
import 'deals.dart';
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
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: DashBoardStats().getDashBoardStats(token),
                    builder: (context, snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        children = [
                          Dashboard(
                            totalSale:
                                snapshot.data!['data']['totalSale'].toString(),
                          ),
                          const SizedBox(height: 8),
                          Stacked_container(
                            discountAvailed: snapshot.data!['data']
                                    ['totalDealRadeem']
                                .toString(),
                          ),
                          const SizedBox(height: 8),
                          Stacked_container2(
                            title: 'Total Active Deals',
                            totalActiveDeals: snapshot.data!['data']
                                    ['totalActiveDeals']
                                .toString(),
                          ),
                          const SizedBox(height: 8),
                          Stacked_container2(
                            title: 'Total Deal Sale',
                            totalActiveDeals: snapshot.data!['data']
                                    ['totalDealSale']
                                .toString(),
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
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
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
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: FutureBuilder<MerchantListOfDeals>(
                    future: DealServices().getAllDeals(token: token),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.data!.data!.isEmpty) {
                            return const Center(
                                child: Text('No deals available'));
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data = snapshot.data!.data![index];
                                return InkWell(
                                  onTap: () {
                                    print(data.id);
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) => sheet_deals(
                                              dealId: data.id.toString(),
                                              token: token,
                                            ));
                                  },
                                  child: Deals(
                                    token: token,
                                    merchantListOfDeals: data,
                                  ),
                                );
                              },
                            );
                          }
                      }
                    },
                  ),
                ),
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
