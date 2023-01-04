import 'package:flutter/material.dart';
import 'package:SiBuy/models/cart_model.dart';
import 'package:SiBuy/providers/deal_provider.dart';
import 'package:SiBuy/user_app/user_menu/my_qrs_cont.dart';
import 'package:provider/provider.dart';

import '../../constant/color_constant.dart';
import '../../shared/loader.dart';

class My_Qrs extends StatefulWidget {
  const My_Qrs({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<My_Qrs> createState() => _My_QrsState();
}

class _My_QrsState extends State<My_Qrs> {
  DealProvider? provider;
  String selectedFilter = 'All';

  @override
  void didChangeDependencies() {
    provider = Provider.of<DealProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.APP_PRIMARY_COLOR,
        title: const Text('My Purchased Deals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              children: [
                //container with small button
                getFilterBox('All'),
                const SizedBox(
                  width: 8,
                ),
                getFilterBox('Available'),
                const SizedBox(
                  width: 8,
                ),
                getFilterBox('Expired'),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              flex: 6,
              child: FutureBuilder<CartListModel>(
                future: provider!.getCartItemsList(widget.token),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Loader();
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
                          return ListView.separated(
                            itemCount: provider!.cartData.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 15);
                            },
                            itemBuilder: (context, index) {
                              if(selectedFilter == "All"){
                                return qr_cont(
                                  key: Key(snapshot.data!.data![index].name!),
                                  cartData: provider!.cartData[index],
                                  token: widget.token,
                                );
                              }
                              else if (provider!.cartData[index].availabilityStatus == selectedFilter) {
                                return qr_cont(
                                  key: Key(snapshot.data!.data![index].name!),
                                  cartData: provider!.cartData[index],
                                  token: widget.token,
                                );
                              }
                              else{
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

  Widget getFilterBox(String text){
    return GestureDetector(
      onTap: (){
        selectedFilter = text;
        setState(() { });
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.045,
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: selectedFilter == text ? AppColors.APP_PRIMARY_COLOR : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: selectedFilter == text ? Colors.white : AppColors.APP_PRIMARY_COLOR
            ),
          ),
        ),
      ),
    );
  }
}
