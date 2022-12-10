import 'package:SiBuy/apis/api_urls.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/models/category_model.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';

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
        child: FutureBuilder<UserDealListModel>(
            future: Provider.of<DealProvider>(context, listen: false)
                .cityWiseDealsList(),
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
                          // return Details_deals(
                          //   token: token,
                          //   dealId: snapshot.data!.data![index].id.toString(),
                          // );
                          return Container(
                            width: double.infinity,
                            height: 100,
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: snapshot
                                                  .data!.data![index].image ==
                                              null
                                          ? const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/kfc.png'),
                                              fit: BoxFit.cover,
                                            )
                                          : DecorationImage(
                                              image: NetworkImage(
                                                  '${ApiUrls.imgBaseUrl}${snapshot.data!.data![index].image!.path!}/${snapshot.data!.data![index].image!.image!}'))),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.data![index].name!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data!.data![index].description!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          //container with text list of deals
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
