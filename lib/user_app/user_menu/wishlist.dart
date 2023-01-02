import 'package:flutter/material.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:provider/provider.dart';
import '../../constant/app_styles.dart';
import '../../constant/color_constant.dart';
import '../../apis/api_urls.dart';
import '../../constant/size_constants.dart';
import '../../models/wish_list_model.dart';
import '../../providers/order.dart';
import '../../shared/custom_button.dart';
import 'cart_user.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key, required this.wishData, required this.token})
      : super(key: key);
  final WishData wishData;
  final String token;

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  String? address = 'Address';

  // Future<void> getMerchantAddress() async {
  //   final result = await UserMerchantServices().singleMerchantProfile(
  //     id: widget.wishData.merchantId.toString(),
  //     token: widget.token,
  //   );

  //   setState(() {
  //     address = result.data!.branches![0].address;
  //   });
  // }

  @override
  void didChangeDependencies() {
    // getMerchantAddress();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: [
          widget.wishData.image == null
              ? Image.asset(
                  'assets/images/cart_deal.png',
                  height: 119,
                )
              : SizedBox(
                  width: 90,
                  height: 119,
                  child: Image.network(
                      '${ApiUrls.imgBaseUrl}${widget.wishData.image!.path}/${widget.wishData.image!.image}'),
                ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      widget.wishData.name!,
                      style: const TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF32324D)),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/menu_location.png',
                          width: 8,
                          height: 8,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          child: Text(
                            address ?? 'Address',
                            softWrap: true,
                            style: const TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF848484)),
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        Image.asset('assets/images/rating.png',
                            width: 6, height: 6),
                        const Text(
                          '4.8',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 7,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF5F5F5F)),
                        ),
                        const Text(
                          '(30 reviews)',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 4,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF5F5F5F)),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 2.83),
                    child: Row(
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
                          '${widget.wishData.price ?? '0'}',
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
                            widget.wishData.discount!.toString(),
                            widget.wishData.price!.toString(),
                          ),
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
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                          child: Center(
                            child: Text(
                              '${widget.wishData.discount}% OFF',
                              style: const TextStyle(
                                  fontSize: 5,
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.APP_PRIMARY_COLOR),
                            ),
                          ),
                        ),
                      ],
                    )),
                Insets.gapH10,
                CustomButton(
                    padding: true,
                    text: 'Add to Cart ➔',
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false).addTCart(
                        merchantId: widget.wishData.merchantId.toString(),
                        id: widget.wishData.id.toString(),
                        price: widget.wishData.price.toString(),
                        title: widget.wishData.name,
                        image: widget.wishData.image!.image ?? '',
                        reviews: '0',
                        discountOnPrice:
                            widget.wishData.discountOnPrice.toString(),
                        path: widget.wishData.image!.path ?? '',
                        isWishList: true,
                      );
                      Provider.of<DealProvider>(context, listen: false)
                          .removeFromWishList(
                              widget.wishData.wishlistId!.toString(),
                              widget.token);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Cart_user(token: widget.token)));
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
