import 'package:SiBuy/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/apis/api_urls.dart';
import '../../constant/color_constant.dart';
import 'package:SiBuy/models/reviews_model.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:provider/provider.dart';

class trending_user extends StatefulWidget {
  const trending_user({Key? key, required this.data, required this.token})
      : super(key: key);
  final UserDealListData data;
  final String token;

  @override
  State<trending_user> createState() => _trending_userState();
}

class _trending_userState extends State<trending_user> {
  // String? merchantAddress = 'Loading...';

  // Future<void> getMerchantAddress() async {
  //   final result = await UserMerchantServices().singleMerchantProfile(
  //     id: widget.data.merchantId.toString(),
  //     token: widget.token,
  //   );

  //   setState(() {
  //     merchantAddress = result.data!.branches![0].address;
  //   });
  // }

  @override
  void didChangeDependencies() {
    // Future.microtask(
    //     () => getRating().whenComplete(() => getMerchantAddress()));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 217,
      width: 145,
      margin: const EdgeInsets.only(right: 8, left: 8),
      decoration: const BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: widget.data.image != null &&
                    widget.data.image!.image!.isNotEmpty
                ? Image.network(
                    '${ApiUrls.imgBaseUrl}${widget.data.image!.path!}/${widget.data.image!.image}',
                    height: 120,
                    width: double.maxFinite)
                : Image.asset(
                    'assets/images/menu.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Text(
            widget.data.name ?? 'no name',
            softWrap: true,
            style: const TextStyle(
                fontFamily: 'Mulish',
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            widget.data.type!.toString(),
            softWrap: true,
            style: const TextStyle(
                fontFamily: 'Mulish',
                fontSize: 7,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF6767)),
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            children: [
              // Image.asset('assets/images/rating.png', width: 6, height: 6),
              Text(
                widget.data.categoryName!,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 7,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5F5F5F)),
              ),
              Text(
                'Merchant: ${widget.data.merchantName}',
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 4,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF5F5F5F)),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            children: [
              const Text(
                '\$',
                style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFF6767)),
              ),
              Text(
                '${widget.data.price ?? '0'}',
                style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontFamily: 'Mulish',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFF6767)),
              ),
              const Text(
                '\$',
                style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppColors.APP_PRIMARY_COLOR),
              ),
              Text(
                Provider.of<DealProvider>(context).calculateDiscount(
                    '${widget.data.discount ?? '0'}',
                    '${widget.data.price ?? '0'}'),
                style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.APP_PRIMARY_COLOR),
              ),
              Container(
                width: 28,
                height: 11,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: Center(
                  child: Text(
                    '${widget.data.discount ?? 0}% OFF',
                    style: const TextStyle(
                        fontSize: 5,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFFFFFF)),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Coupons Left:  ${widget.data.limit}',
            style: const TextStyle(
                fontFamily: 'Mulish',
                fontSize: 5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8E8EA9)),
          ),
        ],
      ),
    );
  }

  ReviewsModel? rating;
  Future<void> getRating() async {
    final result = await Provider.of<DealProvider>(context, listen: false)
        .getDealRating(widget.token, widget.data.id.toString());
    setState(() {
      rating = result;
    });
  }
}
