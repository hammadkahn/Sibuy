import 'package:flutter/material.dart';
import 'package:SiBuy/user_app/categories/categories.dart';
import 'package:SiBuy/user_app/user_menu/cart_user.dart';
import 'package:SiBuy/user_app/user_menu/my_qrs.dart';
import 'package:SiBuy/user_app/user_menu/fav_user.dart';
import 'package:SiBuy/user_app/user_menu/full_user_meu.dart';
import '../../constant/color_constant.dart';

class UserBottomBar extends StatefulWidget {
  const UserBottomBar({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<UserBottomBar> createState() => _UserBottomBarState();
}

class _UserBottomBarState extends State<UserBottomBar> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to exit?'),
          actions: <Widget>[
            TextButton(
              child: const Text('DISCARD'),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: const Text('CONTINUE'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      );
  int currentIndex = 0;

  List<Widget> _children = [];

  final PageStorageBucket bucket = PageStorageBucket();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late Widget currentScreen;

  @override
  void initState() {
    super.initState();

    debugPrint('build: ');
    currentScreen = Full_menu_user(
      token: widget.token,
    );
    _children = [
      Full_menu_user(token: widget.token),
      Categories_user(token: widget.token),
      My_Qrs(token: widget.token),
      Fav_user(token: widget.token),
      Cart_user(token: widget.token),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final canPop = await showWarning(context);
        return canPop ?? false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          body: PageStorage(bucket: bucket, child: currentScreen),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => My_Qrs(token: widget.token),
              ));
            },
            child: Image.asset(
              'assets/images/voucher.png',
              width: 31,
              height: 31,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
              color: AppColors.APP_PRIMARY_COLOR,
              shape: const CircularNotchedRectangle(),
              notchMargin: 0,
              child: SizedBox(
                  height: 64,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        minWidth: 24,
                        onPressed: () {
                          setState(() {
                            currentIndex = 0;
                            currentScreen = Full_menu_user(
                              token: widget.token,
                            );
                          });
                        },
                        child: Image.asset(
                          'assets/images/gigi-logo.png',
                          width: 24,
                          height: 24,
                          color:
                              currentIndex == 0 ? Colors.black : Colors.white,
                        ),
                      ),
                      MaterialButton(
                        minWidth: 24,
                        onPressed: () {
                          setState(() {
                            currentIndex = 1;
                            currentScreen = Categories_user(
                              token: widget.token,
                            );
                          });
                        },
                        child: Image.asset(
                          'assets/images/category.png',
                          width: 24,
                          height: 24,
                          color:
                              currentIndex == 1 ? Colors.black : Colors.white,
                        ),
                      ),
                      MaterialButton(
                        minWidth: 24,
                        onPressed: () {
                          setState(() {
                            currentIndex = 2;
                            currentScreen = Fav_user(token: widget.token);
                          });
                        },
                        child: Image.asset(
                          'assets/images/fav.png',
                          width: 24,
                          height: 24,
                          color:
                              currentIndex == 2 ? Colors.black : Colors.white,
                        ),
                      ),
                      MaterialButton(
                        minWidth: 24,
                        onPressed: () {
                          setState(() {
                            currentIndex = 3;
                            currentScreen = Cart_user(token: widget.token);
                          });
                        },
                        child: Image.asset(
                          'assets/images/cart.png',
                          width: 24,
                          height: 24,
                          color:
                              currentIndex == 3 ? Colors.black : Colors.white,
                        ),
                      )
                    ],
                  )))),
    );
  }
}
