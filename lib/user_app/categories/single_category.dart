import 'package:flutter/material.dart';
import 'package:gigi_app/models/category_model.dart';
import 'package:gigi_app/services/deals/user_deals_services.dart';
import 'package:gigi_app/user_app/user_menu/deals_details.dart';

import '../../models/deal_model.dart';

class SingleCategory extends StatelessWidget {
  const SingleCategory(
      {Key? key, required this.categoryData, required this.token})
      : super(key: key);
  final CategoryData categoryData;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryData.name!),
        backgroundColor: const Color(0xFFff6600),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: FutureBuilder<UserListOfDeals>(
            future: UserDealServices().getAllUserDeals(token),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: ((context, index) {
                        if (snapshot.data!.data![index].categoryName ==
                            categoryData.name) {
                          return Details_deals(
                            token: token,
                            dealId: snapshot.data!.data![index].id.toString(),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    );
                  }
              }
            })),
      ),
    );
  }
}
