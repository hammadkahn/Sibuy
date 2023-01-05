import 'package:SiBuy/apis/api_urls.dart';
import 'package:SiBuy/user_app/user_menu/demi_deals.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/models/deal_model.dart';
import 'package:SiBuy/user_app/user_menu/deals_user.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/user_carousel_model.dart';

class CSlider extends StatelessWidget {

  List<UserCarousel> data;
  CSlider({
    Key? key,
    required this.data
  }) : super(key: key);

  CarouselController? controller = CarouselController();

  Future<void> _launchInBrowser(Uri url) async {
    try {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    double carouselwidth = MediaQuery.of(context).size.width;
    double carouselheight = carouselwidth * 145 / 327;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          // aspectRatio: 1,
          viewportFraction: 1,
          height: 200.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          final imagePath = '${ApiUrls.imgBaseUrl}${data[index].imagePath}/${data[index].image}';
          return buildImage(imagePath, data[index]!.link!);
        },
      ),
    );
  }

  Widget buildImage(String imagePath, String url) {
    return GestureDetector(
      onTap: (){
        print(url);
        url = url.replaceFirst('www', 'https://');
        _launchInBrowser(Uri.parse(url));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        color: Colors.grey[200],
        child: Image(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
