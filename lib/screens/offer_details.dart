// import 'package:flutter/material.dart';
// import 'package:gigi_app/models/deal_model.dart';

// class OfferDetails extends StatefulWidget {
//   const OfferDetails({Key? key, this.dealData}) : super(key: key);
//   final Data? dealData;

//   @override
//   State<OfferDetails> createState() => _OfferDetailsState();
// }

// class _OfferDetailsState extends State<OfferDetails> {
//   static const baseUrl = 'https://gigiapi.zanforthstaging.com/';
//   double? percentage;
//   double? price;
//   double? priceAfterDiscount;
//   String? totalReviews = '0';
//   int? value = 0;
//   var isLaoding = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     percentage = int.parse(widget.dealData!.discountOnPrice!) / 100;
//     price = percentage! * int.parse(widget.dealData!.price!);
//     priceAfterDiscount = int.parse(widget.dealData!.price!) - price!;
//     print(widget.dealData);
//     // totalReviews = Reviews().getRating(widget.data!.reviews!);
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Offer Details'),
//         backgroundColor: const Color(0xFF030381),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 10),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: 250,
//               child: widget.dealData!.image == null ||
//                       widget.dealData!.image!.image!.isEmpty
//                   ? Image.asset(
//                       'assets/images/detail.png',
//                       height: 248,
//                       width: MediaQuery.of(context).size.width,
//                     )
//                   : Image.network(
//                       '$baseUrl${widget.dealData!.image!.path!}/${widget.dealData!.image!.image}',
//                       height: 248,
//                       width: MediaQuery.of(context).size.width,
//                     ),
//             ),
//             const SizedBox(height: 12),
//             Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: ListTile(
//                   title: Text(
//                     widget.dealData!.name ?? 'no name',
//                     style: const TextStyle(
//                         fontFamily: 'Mulish',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF4A4A6A)),
//                   ),
//                   subtitle: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/images/menu_location.png',
//                             width: 8,
//                             height: 8,
//                           ),
//                           const Text(
//                             'Cafe Bistrovia - Baku, Azerbaijan',
//                             style: TextStyle(
//                                 fontFamily: 'Mulish',
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF8E8EA9)),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Image.asset('assets/images/rating.png',
//                               width: 10, height: 10),
//                           Text(
//                             '${widget.dealData!.totalReviews ?? 0}',
//                             style: const TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xFF5F5F5F)),
//                           ),
//                           Text(
//                             '(${widget.dealData!.totalReviews ?? 0} reviews)',
//                             style: const TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w400,
//                                 color: Color(0xFF5F5F5F)),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )),
//             ListTile(
//               title: Row(
//                 children: [
//                   const Text(
//                     '\$',
//                     style: TextStyle(
//                         fontFamily: 'Mulish',
//                         fontSize: 9,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xFFFF6767)),
//                   ),
//                   Text(
//                     widget.dealData!.price ?? '0',
//                     style: const TextStyle(
//                         decoration: TextDecoration.lineThrough,
//                         fontFamily: 'Mulish',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFFFF6767)),
//                   ),
//                   const Text(
//                     '\$',
//                     style: TextStyle(
//                         fontFamily: 'Mulish',
//                         fontSize: 9,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xFF0D9BFF)),
//                   ),
//                   Text(
//                     price.toString(),
//                     style: const TextStyle(
//                         fontFamily: 'Mulish',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF0D9BFF)),
//                   ),
//                   Container(
//                     width: 28,
//                     height: 11,
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(3))),
//                     child: Center(
//                       child: Text(
//                         '${widget.dealData!.discountOnPrice ?? 0}% OFF',
//                         style: const TextStyle(
//                             fontSize: 9,
//                             fontFamily: 'Mulish',
//                             fontWeight: FontWeight.w900,
//                             color: Color(0xFF0D9BFF)),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             ListTile(
//               title: const Text(
//                 'Description',
//                 style: TextStyle(
//                   fontFamily: 'Mulish',
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               subtitle: Text(
//                 widget.dealData!.description ?? 'no description provided',
//                 style: const TextStyle(
//                   fontFamily: 'Mulish',
//                   fontSize: 10,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             ListTile(
//                 title: const Text(
//                   'Deal Reports',
//                   style: TextStyle(
//                     fontFamily: 'Mulish',
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 subtitle: Column(
//                   children: [
//                     Row(
//                       children: [
//                         const Text(
//                           'Total Sales: ',
//                           style: TextStyle(
//                             fontFamily: 'Mulish',
//                             fontSize: 11,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         Text(
//                           '${widget.dealData!.totalPurchase ?? '0'}',
//                           style: const TextStyle(
//                             fontFamily: 'Mulish',
//                             fontSize: 11,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Text(
//                           'Total Reviews: ',
//                           style: TextStyle(
//                             fontFamily: 'Mulish',
//                             fontSize: 11,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         Text(
//                           '${widget.dealData!.totalReviews ?? '0'}',
//                           style: const TextStyle(
//                             fontFamily: 'Mulish',
//                             fontSize: 11,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Text(
//                           'Total Redeem: ',
//                           style: TextStyle(
//                             fontFamily: 'Mulish',
//                             fontSize: 11,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         Text(
//                           '${widget.dealData!.totalRadeem ?? '0'}',
//                           style: const TextStyle(
//                             fontFamily: 'Mulish',
//                             fontSize: 11,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
