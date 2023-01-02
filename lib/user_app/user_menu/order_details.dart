// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
//
// import '../../constant/color_constant.dart';
//
// class order_details extends StatelessWidget {
//   const order_details({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
//         child: ExpandablePanel(
//           header: Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Text(
//               "Offer details and discount",
//               style: TextStyle(
//                   fontFamily: "Mulish",
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF8E8EA9)),
//             ),
//           ),
//           collapsed: Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: Row(
//               children: [
//                 Image.asset(
//                   'assets/images/expand_pic.png',
//                   height: 40,
//                   width: 40,
//                 ),
//                 Text(
//                   "Avocado Chicken Salad",
//                   style: TextStyle(
//                       fontFamily: "Mulish",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF32324D)),
//                 ),
//                 Spacer(),
//                 Text(
//                   "1 x",
//                   style: TextStyle(
//                       fontFamily: "Mulish",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFFA5A5BA)),
//                 ),
//                 Text(
//                   "20% off",
//                   style: TextStyle(
//                       fontFamily: "Mulish",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.APP_PRIMARY_COLOR),
//                 ),
//               ],
//             ),
//           ),
//           expanded: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/expand_pic.png',
//                     height: 40,
//                     width: 40,
//                   ),
//                   Text(
//                     "Avocado Chicken Salad",
//                     style: TextStyle(
//                         fontFamily: "Mulish",
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF32324D)),
//                   ),
//                   Spacer(),
//                   Text(
//                     "1 x",
//                     style: TextStyle(
//                         fontFamily: "Mulish",
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xFFA5A5BA)),
//                   ),
//                   Text(
//                     "20% off",
//                     style: TextStyle(
//                         fontFamily: "Mulish",
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.APP_PRIMARY_COLOR),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 70),
//                 child: Divider(
//                   color: Color(0xFFEAEAEF),
//                   thickness: 1,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 12, bottom: 12),
//                 child: Row(
//                   children: [
//                     Text("Real price",
//                         style: TextStyle(
//                             fontFamily: "Mulish",
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF666687))),
//                     Spacer(),
//                     Text(" \$ 10.42",
//                         style: TextStyle(
//                             fontFamily: "Mulish",
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700,
//                             color: Color(0xFF4A4A6A))),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   Text("Discount",
//                       style: TextStyle(
//                           fontFamily: "Mulish",
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF666687))),
//                   Spacer(),
//                   Text(" \$ 2.00",
//                       style: TextStyle(
//                           fontFamily: "Mulish",
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xFF4A4A6A))),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 16, bottom: 16),
//                 child: Divider(
//                   color: Color(0xFFEAEAEF),
//                   thickness: 1,
//                 ),
//               ),
//               Row(
//                 children: [
//                   Text("Total Price",
//                       style: TextStyle(
//                           fontFamily: "Mulish",
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xFF4A4A6A))),
//                   Spacer(),
//                   Text(" \$ 8.42",
//                       style: TextStyle(
//                           fontFamily: "Mulish",
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.APP_PRIMARY_COLOR)),
//                 ],
//               ),
//               SizedBox(
//                 height: 16,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
