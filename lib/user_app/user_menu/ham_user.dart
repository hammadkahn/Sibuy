import 'package:SiBuy/user_app/user_menu/insights.dart';
import 'package:SiBuy/user_app/user_menu/points.dart';
import 'package:SiBuy/user_app/user_menu/referral.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/models/user_model.dart';
import 'package:SiBuy/services/auth/authentication.dart';
import 'package:SiBuy/services/get_profile/get_user_info.dart';
import 'package:SiBuy/user_app/splash_screen/splash.dart';
import 'package:SiBuy/user_app/user_menu/my_qrs.dart';
import 'package:SiBuy/user_app/user_menu/support_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/api_urls.dart';

class ham_user extends StatefulWidget {
  const ham_user({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<ham_user> createState() => _ham_userState();
}

class _ham_userState extends State<ham_user> {
  String? address = 'Laoding...';

  Future<void> getUserAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      address =
          '${preferences.getString('city')}, ${preferences.getString('country')}';
    });
  }

  @override
  void didChangeDependencies() {
    getUserAddress();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0xffFCFCFC),
            Color(0xffF7F7F7),
            Color(0xffF7F7F7),
            Color(0xffF7F7F7),
            Color(0xffFCFCFC)
          ])),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 29, left: 29),
                    child: SingleChildScrollView(
                        child: FutureBuilder<UserProfileModel>(
                      future: UserInformation().getUserProfile(widget.token),
                      builder: ((context, snapshot) {
                        List<Widget> children;

                        if (snapshot.hasData) {
                          var data = snapshot.data!.data!;
                          children = [
                            GestureDetector(
                              onTap: () {
                                alertBox(data, context);
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    145 /
                                    812,
                                width: MediaQuery.of(context).size.width *
                                    327 /
                                    375,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFff6600),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          20 /
                                          375,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 13, bottom: 10),
                                          child: Text(data.name!,
                                              style: const TextStyle(
                                                  fontFamily: 'DMSans',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffFFFFFF))),
                                        ),
                                        Text('$address\n${data.phone!}',
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontFamily: 'DMSans',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xffFFFFFF))),
                                        Text('${data.email}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: 'DMSans',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xffFFFFFF))),
                                      ],
                                    ),
                                    Spacer(),
                                    data.profilePicture == null ||
                                            data.profilePicture!.isEmpty
                                        ? Image.asset(
                                            'assets/images/slt.png',
                                            height: 50,
                                            width: 50,
                                          )
                                        : Image.network(
                                            '${ApiUrls.imgBaseUrl}${data.profilePicturePath}/${data.profilePicture}',
                                            height: 100,
                                            width: 100,
                                          ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          20 /
                                          375,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding:
                                        EdgeInsets.only(top: 22, bottom: 25),
                                    child: Divider(
                                      color: Color(0xFFE6E6E6),
                                      thickness: 0.5,
                                      // height: 214,
                                      indent: 82,
                                      endIndent: 79,
                                    )),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            My_Qrs(token: widget.token),
                                      ),
                                    );
                                  },
                                  child: const Text("My Offers",
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff32324D))),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 18, bottom: 18),
                                  child: Divider(
                                    color: Color(0xFFE6E6E6),
                                    thickness: 0.5,
                                    // height: 214,
                                    indent: 26,
                                    endIndent: 26,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    data.perference == null ||
                                            data.perference!.isEmpty
                                        ? ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'no preferences added yet',
                                              ),
                                            ),
                                          )
                                        : preferencesBox(
                                            data.perference!, context);
                                  },
                                  child: const Text("My Prefrences",
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff32324D))),
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.only(top: 18, bottom: 18),
                                    child: Divider(
                                      color: Color(0xFFE6E6E6),
                                      thickness: 0.5,
                                      // height: 214,
                                      indent: 26,
                                      endIndent: 26,
                                    )),
                                InkWell(
                                  onTap: () {
                                    alertBox(data, context);
                                  },
                                  child: const Text("My Account",
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff32324D))),
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.only(top: 18, bottom: 18),
                                    child: Divider(
                                      color: Color(0xFFE6E6E6),
                                      thickness: 0.5,
                                      // height: 214,
                                      indent: 26,
                                      endIndent: 26,
                                    )),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Referal(),
                                      ),
                                    );
                                  },
                                  child: const Text("My Payments Method",
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff32324D))),
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.only(top: 18, bottom: 18),
                                    child: Divider(
                                      color: Color(0xFFE6E6E6),
                                      thickness: 0.5,
                                      // height: 214,
                                      indent: 26,
                                      endIndent: 26,
                                    )),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Referal(),
                                      ),
                                    );
                                  },
                                  child: const Text("My Referrals",
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff32324D))),
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.only(top: 18, bottom: 18),
                                    child: Divider(
                                      color: Color(0xFFE6E6E6),
                                      thickness: 0.5,
                                      // height: 214,
                                      indent: 26,
                                      endIndent: 26,
                                    )),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Referal(),
                                      ),
                                    );
                                  },
                                  child: const Text("Change Password",
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff32324D))),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(top: 18, bottom: 18),
                                    child: Divider(
                                      color: Color(0xFFE6E6E6),
                                      thickness: 0.5,
                                      // height: 214,
                                      indent: 26,
                                      endIndent: 26,
                                    )),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Points(),
                                      ),
                                    );
                                  },
                                  child: const Text("My Points",
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff32324D))),
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.only(top: 18, bottom: 18),
                                    child: Divider(
                                      color: Color(0xFFE6E6E6),
                                      thickness: 0.5,
                                      // height: 214,
                                      indent: 26,
                                      endIndent: 26,
                                    )),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Insights(),
                                      ),
                                    );
                                  },
                                  child: const Text("My Insights",
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff32324D))),
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.only(top: 18, bottom: 18),
                                    child: Divider(
                                      color: Color(0xFFE6E6E6),
                                      thickness: 0.5,
                                      // height: 214,
                                      indent: 26,
                                      endIndent: 26,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => support_user(
                                          phoneNumber: data.phone!,
                                          token: widget.token,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Support",
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff32324D))),
                                ),
                              ],
                            ),
                          ];
                        } else if (snapshot.hasError) {
                          children = <Widget>[
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${snapshot.error}'),
                            )
                          ];
                        } else {
                          children = const <Widget>[
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Awaiting result...'),
                            )
                          ];
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        );
                      }),
                    )),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 35, top: 100, bottom: 56),
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logging out...')));
                          signOut().whenComplete(() {
                            if (message == 'success') {
                              isLogOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SplashScreen()),
                                  (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message!)));
                            }
                          });
                        },
                        child: const Text('Log out',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff9E9E9E))),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> isLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  String? message;
  Future<void> signOut() async {
    final msg = await MerchantAuthServices().logOut(widget.token);

    setState(() {
      message = msg;
    });
  }

  void alertBox(UserProfileData userProfileData, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              '${userProfileData.name!}\'s Profile',
              textAlign: TextAlign.center,
            ),
            content: Container(
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFff6600),
                  ),
                  child: ListTile(
                      leading: const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.white,
                      ),
                      title: Text(
                        userProfileData.name!,
                        style: const TextStyle(color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFff6600),
                  ),
                  child: ListTile(
                      leading: const Icon(
                        Icons.email,
                        size: 20,
                        color: Colors.white,
                      ),
                      title: Text(
                        userProfileData.email!,
                        style: const TextStyle(color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFff6600),
                  ),
                  child: ListTile(
                      leading: const Icon(
                        Icons.male,
                        size: 20,
                        color: Colors.white,
                      ),
                      title: Text(
                        userProfileData.gender!,
                        style: const TextStyle(color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFff6600),
                  ),
                  child: ListTile(
                      leading: const Icon(
                        Icons.phone,
                        size: 20,
                        color: Colors.white,
                      ),
                      title: Text(
                        userProfileData.phone!,
                        style: const TextStyle(color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFff6600),
                  ),
                  child: ListTile(
                      leading: const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.white,
                      ),
                      title: Text(
                        userProfileData.age!.toString(),
                        style: const TextStyle(color: Colors.white),
                      )),
                ),
              ]),
            ),
          );
        });
  }

  void preferencesBox(List<Perference> userProfileData, BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(top: 20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              itemCount: userProfileData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor:
                      index % 2 == 0 ? Colors.blue[200] : Colors.blue[100],
                  title: Text(userProfileData[index].categoryName!),
                );
              },
            ),
          );
        });
  }
}
