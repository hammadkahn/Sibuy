import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constant/color_constant.dart';

class carousel extends StatefulWidget {
  const carousel({Key? key}) : super(key: key);

  @override
  State<carousel> createState() => _carouselState();
}

class _carouselState extends State<carousel> {
  int activeIndex = 0;
  Widget buildint() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 3,
        effect: const WormEffect(
          activeDotColor: AppColors.APP_PRIMARY_COLOR,
          dotColor: Colors.white,
          dotHeight: 6,
          dotWidth: 30,
          spacing: 0,
        ),
      );
  @override
  Widget build(BuildContext context) {
    double carouselwidth = MediaQuery.of(context).size.width;
    double carouselheight = carouselwidth * 476 / 375;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xffF4F5F9)),
      width: carouselwidth,
      height: carouselheight,
      /* color: Colors.black, */
      child: Stack(
        children: [
          CarouselSlider(
              items: [
                Image.asset('assets/images/Illustration.png'),
                Image.asset('assets/images/Illustration.png'),
                Image.asset('assets/images/Illustration.png'),
              ],
              options: CarouselOptions(
                height: carouselheight,
                // width: MediaQuery.of(context).size.width,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              )),
          Positioned.fill(
            bottom: 6,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: buildint(),
            ),
          )
        ],
      ),
    );
  }
}
