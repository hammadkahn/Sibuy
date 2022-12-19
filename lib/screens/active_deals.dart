import 'package:flutter/material.dart';
import 'package:SiBuy/models/deal_model.dart';
import 'package:SiBuy/screens/full_menu/sheet_deals.dart';
import 'package:SiBuy/services/deals/merchant_deal_services.dart';

import '../constant/color_constant.dart';
import '../user_app/user_menu/demi_deals.dart';
import 'full_menu/deals.dart';

class ActiveMerchantDeals extends StatelessWidget {
  const ActiveMerchantDeals({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Deals'),
        backgroundColor: AppColors.APP_PRIMARY_COLOR,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: FutureBuilder<MerchantDealListModel>(
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
                  return Column(
                    children: const [
                      Demo_Deals(),
                      Demo_Deals(),
                      Demo_Deals(),
                    ],
                  );
                  // Center(child: Text('No deals available'));
                } else {
                  print(snapshot.data!.data!.length);
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.data![index];
                      return InkWell(
                        onTap: () => showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => sheet_deals(
                                dealId: data.id.toString(), token: token)),
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
    );
  }
}
