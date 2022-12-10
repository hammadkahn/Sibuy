import 'package:flutter/material.dart';
import 'package:SiBuy/chat/user_list_screen.dart';
import 'package:SiBuy/screens/QR/qr.dart';
import 'package:SiBuy/screens/full_menu/menu.dart';
import 'package:SiBuy/screens/full_menu/profile.dart';

import 'add_deal.dart';

class Bar extends StatefulWidget {
  const Bar({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
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
  // String? token;
  int currentIndex = 0;

  List<Widget> _children = List.empty(growable: true);

  final PageStorageBucket bucket = PageStorageBucket();

  late Widget currentScreen;

  @override
  void initState() {
    super.initState();
    currentScreen = Menu(token: widget.token);
    _children = [
      Menu(
        token: widget.token,
      ),
      Add_deal(token: widget.token),
      QR(token: widget.token),
      UserListScreen(token: widget.token),
      Profile(
        token: widget.token,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('backbutton pressed');
        final canPop = await showWarning(context);
        return canPop ?? false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageStorage(bucket: bucket, child: currentScreen),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => QR(token: widget.token)));
          },
          child: Image.asset(
            'assets/images/auth_pic.png',
            width: 31,
            height: 31,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFFff6600),
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
                      currentScreen = Menu(token: widget.token);
                    });
                  },
                  child: Image.asset(
                    'assets/images/home.png',
                    width: 24,
                    height: 24,
                    color: currentIndex == 0 ? Colors.black : Colors.white,
                  ),
                ),
                MaterialButton(
                  minWidth: 24,
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                      currentScreen = Add_deal(token: widget.token);
                    });
                  },
                  child: Icon(
                    Icons.add_box_outlined,
                    color: currentIndex == 1 ? Colors.black : Colors.white,
                  ),
                  // child: Image.asset(
                  //   'assets/images/contact.png',
                  //   width: 24,
                  //   height: 24,
                  //   color: currentIndex == 1 ? Colors.black : Colors.white,
                  // ),
                ),
                MaterialButton(
                  minWidth: 24,
                  onPressed: () {
                    setState(() {
                      currentIndex = 2;
                      currentScreen = UserListScreen(token: widget.token);
                    });
                  },
                  child: Image.asset(
                    'assets/images/chat.png',
                    width: 24,
                    height: 24,
                    color: currentIndex == 2 ? Colors.black : Colors.white,
                  ),
                ),
                MaterialButton(
                  minWidth: 24,
                  onPressed: () {
                    setState(() {
                      currentIndex = 3;
                      currentScreen = Profile(
                        token: widget.token,
                      );
                    });
                  },
                  child: Image.asset(
                    'assets/images/profile.png',
                    width: 24,
                    height: 24,
                    color: currentIndex == 3 ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
