import 'package:flutter/material.dart';
import 'package:gigi_app/providers/deal_provider.dart';
import 'package:gigi_app/user_app/user_menu/user_menu.dart';
import 'package:gigi_app/user_app/user_menu/wishlist.dart';
import 'package:provider/provider.dart';

import '../../models/wish_list_model.dart';

class Fav_user extends StatefulWidget {
  const Fav_user({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<Fav_user> createState() => _Fav_userState();
}

class _Fav_userState extends State<Fav_user> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 32, top: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => User_bar(token: widget.token)));
                        },
                        child: Image.asset('assets/images/arrow-left.png')),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 22),
                    child: Text(
                      'Your Wishlist',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF32324D)),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Consumer<DealProvider>(
                      builder: ((__, value, _) {
                        return FutureBuilder<WishListModel>(
                          future: value.getWishList(widget.token),
                          builder: ((context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return const Center(
                                    child: CircularProgressIndicator());
                              default:
                                if (snapshot.hasError) {
                                  return Column(
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 60,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Text('Error: ${snapshot.error}'),
                                      )
                                    ],
                                  );
                                } else {
                                  var data = snapshot.data!.data!;
                                  return ListView.builder(
                                    itemCount: data.length,
                                    shrinkWrap: true,
                                    itemBuilder: ((context, index) {
                                      return Dismissible(
                                        key: Key(data[index].id.toString()),
                                        onDismissed: (direction) {
                                          value
                                              .removeFromWishList(
                                                  data[index]
                                                      .wishlistId
                                                      .toString(),
                                                  widget.token)
                                              .whenComplete(() =>
                                                  showSnackBar(value.msg));
                                        },
                                        direction: DismissDirection.endToStart,
                                        background: Container(
                                          color: Colors.red,
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Wishlist(
                                            wishData: data[index],
                                            token: widget.token),
                                      );
                                    }),
                                  );
                                }
                            } //test
                          }),
                        );
                      }),
                    )),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }
}
