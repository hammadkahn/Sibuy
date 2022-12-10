import 'package:SiBuy/services/deals/merchant_deal_services.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/screens/QR/qr_scan.dart';
import 'package:SiBuy/shared/custom_button.dart';

class QR extends StatefulWidget {
  const QR({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<QR> createState() => _QRState();
}

class _QRState extends State<QR> {
  final uniqueCodeCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 24, left: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Scan the QR of Deal',
                  style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 22,
                      color: Color(0xFF32324D),
                      fontWeight: FontWeight.w500),
                ),
                //QR_CODE SCANNER
                Padding(
                  padding: const EdgeInsets.only(top: 70, bottom: 71),
                  child: Image.asset('assets/images/Content.png'),
                ),
                const Text(
                  'Please scan the QR Code',
                  style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 16,
                      color: Color(0xFF8E8EA9),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    //alert box with text feild
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Enter the code'),
                            content: TextFormField(
                              controller: uniqueCodeCtr,
                              onChanged: (value) {
                                //code = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: uniqueCodePurchased,
                                child: const Text('Submit'),
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Enter QR Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 38),
                  child: CustomButton(
                    text: 'Scan QR',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => QR_scan(
                            title: "QR Scanner",
                            token: widget.token,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // CustomButton(
                //   text: 'Scannned details',
                //   onPressed: () {
                //     Navigator.of(context)
                //         .push(MaterialPageRoute(builder: (_) => Scanned_details()));
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uniqueCodePurchased() async {
    final result = await DealServices()
        .redeemWithCode(widget.token, uniqueCodeCtr.text)
        .whenComplete(() => Navigator.of(context).pop());

    if (result == 'This unique code does not exists') {
      showSnackBar('This unique code does not exists');
    } else {
      showSnackBar('Redeemed successfully');
    }
  }

  showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }
}
