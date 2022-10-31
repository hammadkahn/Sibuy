import 'package:flutter/material.dart';
import 'package:SiBuy/models/cart_model.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:SiBuy/user_app/user_menu/my_qrs_cont.dart';
import 'package:provider/provider.dart';

class My_Qrs extends StatefulWidget {
  const My_Qrs({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<My_Qrs> createState() => _My_QrsState();
}

class _My_QrsState extends State<My_Qrs> {
  DealProvider? provider;

  @override
  void didChangeDependencies() {
    provider = Provider.of<DealProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF6600),
        title: const Text('My QRs'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 24, left: 24),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/images/arrow-left.png')),
                  ),
                  const Spacer(),
                  const Text('My QR’s',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 14,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            //row with 3 small contianers
            Row(
              children: [
                //container with small button
                Container(
                  height: MediaQuery.of(context).size.height * 40 / 812,
                  width: MediaQuery.of(context).size.width * 60 / 375,
                  decoration: BoxDecoration(
                    color: Color(0xFFff6600),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'All',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 40 / 812,
                  width: MediaQuery.of(context).size.width * 60 / 375,
                  decoration: BoxDecoration(
                    color: Color(0xFFff6600),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Used',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 40 / 812,
                  width: MediaQuery.of(context).size.width * 60 / 375,
                  decoration: BoxDecoration(
                    color: Color(0xFFff6600),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Unused',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),

            Expanded(
              flex: 6,
              child: FutureBuilder<CartListModel>(
                future: provider!.getCartItemsList(widget.token),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        if (snapshot.data!.data == null ||
                            snapshot.data!.data!.isEmpty) {
                          return const Center(
                            child: Text('no data found'),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: provider!.cartData.length,
                            itemBuilder: (context, index) {
                              if (provider!
                                      .cartData[index].availabilityStatus ==
                                  "Available") {
                                return qr_cont(
                                  key: Key(snapshot.data!.data![index].name!),
                                  cartData: provider!.cartData[index],
                                  token: widget.token,
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          );
                        }
                      }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
