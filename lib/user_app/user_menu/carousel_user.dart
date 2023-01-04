import 'package:SiBuy/user_app/user_menu/demi_deals.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/models/deal_model.dart';
import 'package:SiBuy/user_app/user_menu/deals_user.dart';

class CSlider extends StatefulWidget {
  const CSlider({
    Key? key,
  }) : super(key: key);
  // final String token;

  @override
  State<CSlider> createState() => _CSliderState();
}

class _CSliderState extends State<CSlider> {
  DateTime now = DateTime.now();
  DateTime? now_1w;
  final List<String> imagePaths = [
    'assets/images/menu.png',
    'assets/images/TV.png',
  ];

  CarouselController? controller = CarouselController();

  @override
  void dispose() {
    super.dispose();
  }

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    double carouselwidth = MediaQuery.of(context).size.width;
    double carouselheight = carouselwidth * 145 / 327;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CarouselSlider.builder(
        // items: imagePaths.map((path) {
        //   return Container(
        //     child: Image(image: AssetImage(path)),
        //   );
        // }).toList(),
        options: CarouselOptions(
          aspectRatio: 2.0,
          height: 200.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          final imagepath = imagePaths[index];

          return buildImage(imagepath, index);
        },
      ),
    );
  }

  Widget buildImage(String imagePath, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      color: Colors.grey[200],
      child: Image(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      ),
    );
  }
}
