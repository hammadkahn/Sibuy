import 'package:flutter/material.dart';
import 'package:gigi_app/apis/api_urls.dart';
import 'package:gigi_app/models/category_model.dart';

class TrendingDealsWidget extends StatelessWidget {
  const TrendingDealsWidget({Key? key, required this.categoryData})
      : super(key: key);

  final CategoryData categoryData;
  @override
  Widget build(BuildContext context) {
    debugPrint(
        '${ApiUrls.imgBaseUrl}${categoryData.imagePath}/${categoryData.image}');
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        top: 5,
        bottom: 5,
      ),
      child: Container(
        height: 121,
        width: 125,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            categoryData.image == null || categoryData.image!.isEmpty
                ? Image.asset(
                    'assets/images/voucher.png',
                    height: 100,
                    width: 100,
                  )
                : Image.network(
                    '${ApiUrls.imgBaseUrl}${categoryData.imagePath}/${categoryData.image}',
                    height: 100,
                    width: 100,
                  ),
            Text(categoryData.name!),
          ],
        ),
      ),
    );
  }
}
