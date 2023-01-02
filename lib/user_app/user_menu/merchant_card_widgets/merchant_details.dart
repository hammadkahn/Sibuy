import 'package:flutter/material.dart';
import 'package:SiBuy/models/top_mecrchant_model.dart';
import 'package:SiBuy/services/user_merchant_services.dart';
import 'package:SiBuy/user_app/user_menu/merchant_card_widgets/details_card.dart';

import '../../../shared/loader.dart';

class MerchantDetails extends StatelessWidget {
  const MerchantDetails(
      {Key? key, required this.token, this.city = '', required this.country})
      : super(key: key);
  final String token;
  final String? city;
  final String country;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopMerchantModel>(
      future: UserMerchantServices().getTopMerchant(token, country, city!),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Loader();
          default:
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    if (snapshot.data!.data![index].statusName == null ||
                        snapshot.data!.data![index].statusName ==
                            "Not verified") {
                      return const SizedBox();
                    } else {
                      return GestureDetector(
                        child: DetailsCardWidget(
                          data: snapshot.data!.data![index],
                          merchantId: snapshot.data!.data![index].id.toString(),
                          token: token,
                        ),
                      );
                    }
                  }));
            }
        }
      }),
    );
  }
}
