import 'package:flutter/material.dart';
import 'package:SiBuy/screens/QR/qr_scan.dart';
import 'package:SiBuy/shared/custom_button.dart';

class QR extends StatelessWidget {
  const QR({Key? key, required this.token}) : super(key: key);
  final String token;

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
                SizedBox(
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
                            content: TextField(
                              onChanged: (value) {
                                //code = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => QRScan()),
                                  // );
                                },
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
                    text: 'Scan Now',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => QR_scan(
                                title: "QR Scanner",
                                token: token,
                              )));
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
}
