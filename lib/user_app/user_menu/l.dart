import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gigi_app/models/deal_model.dart';
import 'package:gigi_app/user_app/user_menu/deals_user.dart';

class C_slider extends StatefulWidget {
  const C_slider({Key? key, required this.merchantList, required this.token})
      : super(key: key);
  // final String token;
  final List<DealData> merchantList;
  final String token;

  @override
  State<C_slider> createState() => _C_sliderState();
}

class _C_sliderState extends State<C_slider> {
  DateTime now = DateTime.now();
  DateTime? now_1w;
  List<DealData> weekDeals = [];
  String? reviews;
  CarouselController? controller = CarouselController();

  getDealsDate(DateTime now, DateTime nowW1) {
    for (int i = 0; i < widget.merchantList.length; i++) {
      DateTime createdDate =
          DateTime.parse(widget.merchantList[i].createdAt.toString());
      if ((createdDate.compareTo(nowW1) > 0) && now.isAfter(createdDate)) {
        weekDeals.add(widget.merchantList[i]);
      }
    }
  }

  @override
  void initState() {
    now_1w = now.subtract(const Duration(days: 7));
    getDealsDate(now, now_1w!);

    super.initState();
  }

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
      child: weekDeals.isEmpty
          ? const Center(
              child: Text(
                'No week offers available',
                textScaleFactor: 1.1,
              ),
            )
          : CarouselSlider.builder(
              itemCount: weekDeals.length,
              itemBuilder: ((context, index, realIndex) {
                return dealsUser(
                  token: widget.token,
                  dealData: weekDeals[index],
                );
              }),
              options: CarouselOptions(
                pauseAutoPlayInFiniteScroll: true,
                aspectRatio: 2.0,
                height: carouselheight,

                // width: MediaQuery.of(context).size.width,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 3000),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: weekDeals.length > 5 ? false : true,
                reverse: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  if (mounted) {
                    setState(() {
                      activeIndex = index;
                    });
                  }
                },
              ),
              carouselController: controller,
            ),
    );
  }
}
