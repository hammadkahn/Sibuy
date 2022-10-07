import 'package:flutter/material.dart';
import 'package:gigi_app/models/deal_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'deals_details.dart';
import 'trending.dart';

class all_details extends StatefulWidget {
  const all_details({Key? key, required this.dealId, required this.token})
      : super(key: key);
  final DealData dealId;
  final String token;

  get dealData => null;

  @override
  State<all_details> createState() => _all_detailsState();
}

class _all_detailsState extends State<all_details> {
  @override
  void initState() {
    super.initState();
    print('name : ${widget.dealId.name}');
  }

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: trending_user(
          data: widget.dealId,
          token: widget.token,
        ),
        onTap: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
            isScrollControlled: true,
            context: context,
            builder: (ct) => Scaffold(
              key: _key,
              extendBody: false,
              body: SingleChildScrollView(
                controller: ModalScrollController.of(ct),
                child: widget.dealId.id == null
                    ? const Center(child: CircularProgressIndicator())
                    : Details_deals(
                        dealId: widget.dealId.id.toString(),
                        token: widget.token,
                      ),
              ),
            ),
          );
        });
  }
}
