import 'package:flutter/material.dart';
import 'package:SiBuy/models/category_model.dart';

import '../single_category.dart';

class AllCategoriesWidget extends StatelessWidget {
  const AllCategoriesWidget(
      {Key? key,
      required this.length,
      required this.direction,
      required this.categoryList,
      required this.token})
      : super(key: key);
  final int length;
  final Axis direction;
  final List<CategoryData> categoryList;
  final String token;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: length,
      separatorBuilder: (BuildContext context, int index) => const Padding(padding: EdgeInsets.only(top: 5, bottom: 5), child: Divider(color: Color(0xFFE6E6E6), thickness: 1)),
      itemBuilder: ((context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SingleCategory(
                    categoryData: categoryList[index], token: token),
              ),
            );
          },
          child: Text(categoryList[index].name!,
              style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF32324D))),
        );
      }),
    );
  }
}
