import 'package:SiBuy/user_app/user_menu/demi_deals.dart';
import 'package:flutter/material.dart';

class All_offer extends StatelessWidget {
  const All_offer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFff6600),
        title: const Text('All Offers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              Text('All Offers'),
              Demo_Deals(),
              Demo_Deals(),
              Demo_Deals(),
            ],
          ),
        ),
      ),
    );
  }
}
