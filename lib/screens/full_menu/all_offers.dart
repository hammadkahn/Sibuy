import 'package:SiBuy/screens/full_menu/sheet_deals.dart';
import 'package:SiBuy/user_app/user_menu/demi_deals.dart';
import 'package:flutter/material.dart';
import '../../constant/color_constant.dart';
import '../../models/deal_model.dart';
import '../../services/deals/merchant_deal_services.dart';
import '../../shared/loader.dart';
import 'deals.dart';

class All_offer extends StatelessWidget {
  const All_offer({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.APP_PRIMARY_COLOR,
        title: const Text('All Offers'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
