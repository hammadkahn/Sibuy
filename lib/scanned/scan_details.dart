import 'package:flutter/material.dart';
import 'package:SiBuy/scanned/thank_you_screen.dart';
import 'package:SiBuy/services/deals/merchant_deal_services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../constant/color_constant.dart';
import '../shared/custom_button.dart';

// ignore: camel_case_types
class Scanned_details extends StatefulWidget {
  const Scanned_details(
      {Key? key, required this.token, required this.scannedData})
      : super(key: key);
  final String token;
  final Barcode scannedData;

  @override
  State<Scanned_details> createState() => _Scanned_detailsState();
}

class _Scanned_detailsState extends State<Scanned_details> {
  // final String userName;
  final ctr = TextEditingController();
  List? details;
  double? percentage;
  double? price;
  double? priceAfterDiscount;

  @override
  void initState() {
    details = widget.scannedData.code!.split(':');
    super.initState();
    print(details);
  }

  @override
  Widget build(BuildContext context) {
    // final result = scannedData.rawBytes as Map<String, dynamic>;

    debugPrint('result : ${widget.scannedData.code}');
    return Scaffold(
      body: Center(
        child: details!.length <= 2
            ? const Text('This is qr code is generated with old pattern')
            : Padding(
                padding: const EdgeInsets.only(top: 137, right: 24, left: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                        'This user Have ${details![3]}% OFF on\n${details!.last}\n',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.APP_PRIMARY_COLOR,
                        )),
                    Text(
                      'Discount Type: ${details![5]}\nQuantity: ${details![2]}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff8E8EA9)),
                    ),
                    int.parse(details![2]) <= 0
                        ? const Center(
                            child: Text('Out of Stock'),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 34.5),
                            child: TextField(
                                controller: ctr,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFFEAEAEF)),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    hintText: 'Enter Price of the Bill',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calculate),
                                      onPressed: () {
                                        setState(() {
                                          percentage =
                                              int.parse(details![3]) / 100;
                                          price =
                                              percentage! * int.parse(ctr.text);
                                          priceAfterDiscount =
                                              int.parse(ctr.text) - price!;
                                        });
                                        debugPrint(
                                            priceAfterDiscount.toString());
                                      },
                                    ))),
                          ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          priceAfterDiscount == null
                              ? 'Enter the price to calculate discount'
                              : 'You have to charge this user of an amount of ${priceAfterDiscount!.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: AppColors.APP_PRIMARY_COLOR, fontSize: 18),
                        )),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 38),
                      child: CustomButton(
                        text: 'Submit',
                        onPressed: priceAfterDiscount == null
                            ? () => snackBar(
                                'Please the price of the bill to calculate the discount on price')
                            : () {
                                snackBar('Processing...');
                                redeemResult().whenComplete(() {
                                  if (msg == 'success') {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => ThankYouPage(
                                                  token: widget.token,
                                                )));
                                  } else {
                                    snackBar('Error: $msg');
                                  }
                                });
                              },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void snackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  String? msg;
  Future<void> redeemResult() async {
    try {
      final result = await DealServices()
          .redeemPurchase(widget.token, details![0], details![1])
          .catchError((error, stacktrace) {
        setState(() {
          msg = 'this deal belongs to other merchant';
        });
      });

      setState(() {
        msg = result;
      });
    } catch (e) {
      debugPrint('this deal belongs to other merchant $e');
    }
  }
}
