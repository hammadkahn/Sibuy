import 'package:SiBuy/apis/api_urls.dart';
import 'package:SiBuy/constant/size_constants.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/models/category_model.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../shared/loader.dart';
import '../user_menu/deals_details.dart';

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
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FutureBuilder<UserDealListModel>(
            future: Provider.of<DealProvider>(context, listen: false)
                .categoryWiseDealsList(categoryData.id),
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
                    return ListView.separated(
                      itemCount: snapshot.data!.data!.length,
                      separatorBuilder: (context, index){
                        return const Padding(
                          padding: EdgeInsets.all(10.0),
                          // child: Divider(thickness: 1,),
                        );
                      },
                      itemBuilder: ((context, index) {
                        if (snapshot.data!.data![index].categoryName ==
                            categoryData.name) {
                          // return Details_deals(
                          //   token: token,
                          //   dealId: snapshot.data!.data![index].id.toString(),
                          // );
                          return InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
                                isScrollControlled: true,
                                context: context,
                                builder: (ct) => Wrap(
                                  children: [
                                    snapshot.data!.data![index].id == null
                                        ? Loader()
                                        : Details_deals(
                                      context: context,
                                      dealId: snapshot.data!.data![index].id.toString(),
                                      token: token,
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              // margin: const EdgeInsets.symmetric(
                              //     vertical: 15, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.5),
                                //     spreadRadius: 5,
                                //     blurRadius: 7,
                                //     offset: const Offset(0, 3),
                                //   ),
                                // ],
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
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.55,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.data![index].name!,
                                          maxLines: 3,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot.data!.data![index].description??'',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
