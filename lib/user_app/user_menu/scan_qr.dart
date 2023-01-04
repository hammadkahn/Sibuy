import 'package:flutter/material.dart';
import 'package:SiBuy/models/branch_model.dart';
import 'package:SiBuy/models/cart_model.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../constant/app_styles.dart';
import '../../constant/color_constant.dart';
import '../../shared/loader.dart';

class scan_qr extends StatefulWidget {
  const scan_qr({Key? key, required this.qrCode, required this.token})
      : super(key: key);
  final CartData qrCode;
  final String token;
  @override
  State<scan_qr> createState() => _scan_qrState();
}

class _scan_qrState extends State<scan_qr> {
  DealProvider? _provider;
  List<BranchData>? branchData;

  Future<void> getMerchantDetails() async {
    final result = await _provider!
        .singleDealDetails(widget.token, widget.qrCode.id.toString());
    setState(() {
      branchData = _provider!.dealData!.branches;
    });
  }

  int? branchId;
  int? selectedIndex;
  showAlertDialog() {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: branchData!.length,
          itemBuilder: ((context, index) {
            return ListTile(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  branchId = branchData![index].id;
                  isLoaded = true;
                });
              },
              title: Text(branchData![index].name!),
              subtitle: Text(
                branchData![index].address ?? 'no address',
                softWrap: true,
                style: const TextStyle(),
              ),
              trailing: Icon(
                selectedIndex == index ? Icons.circle : Icons.circle_outlined,
                color: Colors.red,
              ),
            );
          })),
    );
  }

  bool? isLoaded = false;
  @override
  void initState() {
    _provider = Provider.of<DealProvider>(context, listen: false);
    getMerchantDetails().whenComplete(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(right: 24, left: 24, top: 15, bottom: 100),
          child: Column(
            children: [
              const Text(
                'Show this QR on outlet \n to avail this offer',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DMSans',
                    color: Color(0xFF32324D)),
              ),
              const SizedBox(height: 25),
              branchData == null
                  ? Loader()
                  : isLoaded == false
                      ? showAlertDialog()
                      : QrImage(
                          data:
                              '${widget.qrCode.purchaseId}:$branchId:${widget.qrCode.purchaseQuantity}:${widget.qrCode.discountOnPrice}:${widget.qrCode.price}:${widget.qrCode.type}:${widget.qrCode.availabilityStatus}:${widget.qrCode.name}',
                          version: QrVersions.auto,
                          size: 320,
                          gapless: false,
                        ),
              SizedBox(height: 20),
              Text('QR Code: ${widget.qrCode.name}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                      color: Color(0xFF8E8EA9))),
              const SizedBox(height: 29),
              const Text('Your Offer ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                      color: Color(0xFF8E8EA9))),
              Text(widget.qrCode.name!,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                      color: AppColors.APP_PRIMARY_COLOR)),
              Text('${widget.qrCode.discountOnPrice}% Discount',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                      color: Color(0xFF8E8EA9))),
              const SizedBox(height: 29),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Get Date: ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Mulish',
                          color: Color(0xFF343434))),
                  Text(
                      DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(widget.qrCode.purchaseDate!)),
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Mulish',
                          color: Color(0xFF8E8EA9))),
                ],
              ),
              Insets.gapH10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Expiry Date: ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Mulish',
                          color: Color(0xFF343434))),
                  Text(widget.qrCode.expiry!,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Mulish',
                          color: Color(0xFF8E8EA9))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
