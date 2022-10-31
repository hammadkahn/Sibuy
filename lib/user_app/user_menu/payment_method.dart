import 'package:flutter/material.dart';

class Payments extends StatelessWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFff6600),
          title: const Text('Payment Method'),
        ),
        //LIST WITH TWO PAYMENT METHODS
        body: Center(
          child: Column(
            children: [
              //PAYPAL
              Container(
                margin: const EdgeInsets.all(12),
                //decoration
                decoration: BoxDecoration(
                  color: Color(0xFFFF66000),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/paypal.png',
                    height: 50,
                    width: 50,
                  ),
                  title: const Text(
                    'Paypal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              //CREDIT CARD
              Container(
                margin: const EdgeInsets.all(12),
                //decoration
                decoration: BoxDecoration(
                  color: Color(0xFFFF66000),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/credit.png',
                    height: 50,
                    width: 50,
                  ),
                  title: const Text(
                    'Credit Card',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
