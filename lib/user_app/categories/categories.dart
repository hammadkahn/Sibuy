import 'package:flutter/material.dart';
import 'package:SiBuy/models/category_model.dart';
import 'package:SiBuy/services/categories/category_services.dart';
import 'package:SiBuy/shared/location_user.dart';
import 'package:SiBuy/user_app/categories/single_category.dart';
import 'package:SiBuy/user_app/categories/widget/categories_list.dart';

import '../../constant/app_styles.dart';
import '../../shared/loader.dart';
import '../../shared/no_internet_widget.dart';
import 'widget/trending_deals.dart';

class Categories_user extends StatefulWidget {
  Categories_user({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<Categories_user> createState() => _Categories_userState();
}

class _Categories_userState extends State<Categories_user> {

  int parentId = -1;
  String parentName = '';

  bool isInternetAvailable = true;

  @override
  void initState() {
    // TODO: implement initState
    UiUtils.checkInternet().then((value){
      isInternetAvailable = value;
      print('isInternetAvailable');
      print(isInternetAvailable);
      setState(() { });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: !isInternetAvailable ? NoInternetWidget() : Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Location_bar_user(
                token: widget.token,
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            const Text('Popular deals in your area',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF32324D),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 131,
                child: FutureBuilder<GetAllCategoriesModel>(
                    future: CategoryServices().getAllCategories(token: widget.token),
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
                            // return AllCategoriesWidget(
                            //   length: 3,
                            //   direction: Axis.horizontal,
                            //   categoryList: snapshot.data!.data!,
                            // );
                            var list = getParents(snapshot.data!.data!);
                            // parentId = list[0].id;
                            // print(parentId);
                            return ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState((){
                                      parentId = list[index].id;
                                      parentName = list[index].name;
                                    });
                                    print(parentId);
                                  },
                                  child: TrendingDealsWidget(
                                    categoryData: list![index],
                                  ),
                                );
                              }),
                            );
                          }
                      }
                    })),
                // child: FutureBuilder(builder: ((context, snapshot) {

                // }),)
              ),
            ),
            const SizedBox(
              height: 19,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFFD9D9D9)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFFD9D9D9)),
                  ),
                ),
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFFD9D9D9)),
                ),
              ],
            ),
            const SizedBox(
              height: 42,
            ),
            parentName.isNotEmpty ? Text('$parentName Categories',
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF505050),
                )
            ) : Container(),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: FutureBuilder<GetAllCategoriesModel>(
                  future: CategoryServices().getAllCategories(token: widget.token),
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
                          var list = getChildren(snapshot.data!.data!, parentId);
                          return AllCategoriesWidget(
                            token: widget.token,
                            length: list.length,
                            direction: Axis.vertical,
                            categoryList: list,
                          );
                        }
                    }
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      )
      ),
    );
  }

  getParents(List<CategoryData> list){
    return list.where((element) => element.parentId == 0).toList();
  }

  getChildren(List<CategoryData> list, parentId){
    return list.where((element) => element.parentId == parentId).toList();
  }
}
