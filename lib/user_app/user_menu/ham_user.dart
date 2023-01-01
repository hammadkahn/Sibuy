import 'package:SiBuy/user_app/user_auth/user_auth.dart';
import 'package:SiBuy/user_app/user_menu/insights.dart';
import 'package:SiBuy/user_app/user_menu/my_profile.dart';
import 'package:SiBuy/user_app/user_menu/points.dart';
import 'package:SiBuy/user_app/user_menu/referral.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/models/user_model.dart';
import 'package:SiBuy/services/auth/authentication.dart';
import 'package:SiBuy/services/get_profile/get_user_info.dart';
import 'package:SiBuy/user_app/user_menu/my_qrs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/api_urls.dart';
import '../../chat/user_list_screen.dart';
import '../../constant/color_constant.dart';
import '../../shared/custom_button.dart';
import '../../shared/loader.dart';
import 'change_pass.dart';
import 'payment_method.dart';

class ham_user extends StatefulWidget {
  const ham_user({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<ham_user> createState() => _ham_userState();
}

class _ham_userState extends State<ham_user> {
  String? address = 'Laoding...';

  bool isLoading = false;
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
                  flex: 7,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => My_Profile(
                                              token: widget.token,
                                              userData: {
                                                'name': data.name,
                                                'phone_no': data.phone,
                                                'dob': data.dateOfBirth ?? '',
                                                'gender': data.gender,
                                              },
                                            ))).then((value) {
                                  setState(() {});
                                });
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
                                  color: AppColors.APP_PRIMARY_COLOR,
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
                                        Text(
                                            '${data.userLocations == null || data.userLocations!.isEmpty ? 'no address found' : data.userLocations![0].address ?? 'no address found'}\n${data.phone!}',
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
                                    const Spacer(),
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
                                        EdgeInsets.only(top: 22, bottom: 10),
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
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.discount,
                                        color: Color(0xff32324D),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                10 /
                                                375,
                                      ),
                                      const Text("My Offers",
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff32324D))),
                                    ],
                                  ),
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
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.settings_accessibility,
                                        color: Color(0xff32324D),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                10 /
                                                375,
                                      ),
                                      const Text("My Preferences",
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff32324D))),
                                    ],
                                  ),
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
                                          builder: (context) =>
                                              const Payments()),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      //icon for payment method
                                      const Icon(
                                        Icons.payment,
                                        color: Color(0xff32324D),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                10 /
                                                375,
                                      ),
                                      const Text("My Payments Method",
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff32324D))),
                                    ],
                                  ),
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
                                        builder: (context) => const Referal(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.share_outlined,
                                        color: Color(0xff32324D),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                10 /
                                                375,
                                      ),
                                      const Text("My Referrals",
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff32324D))),
                                    ],
                                  ),
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
                                        builder: (context) =>
                                            Change_pass(token: widget.token),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.password_outlined,
                                        color: Color(0xff32324D),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                10 /
                                                375,
                                      ),
                                      const Text("Change Password",
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff32324D))),
                                    ],
                                  ),
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
                                        builder: (context) => const Points(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.point_of_sale_rounded,
                                        color: Color(0xff32324D),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                10 /
                                                375,
                                      ),
                                      const Text("My Points",
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff32324D))),
                                    ],
                                  ),
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
                                        builder: (context) => const Insights(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.insights,
                                        color: Color(0xff32324D),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                10 /
                                                375,
                                      ),
                                      const Text("My Insights",
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff32324D))),
                                    ],
                                  ),
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
                                          builder: (_) => UserListScreen(
                                              token: widget.token)),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.support_agent,
                                        color: Color(0xff32324D),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                10 /
                                                375,
                                      ),
                                      const Text("Support",
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff32324D))),
                                    ],
                                  ),
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
                          children = <Widget>[
                            Loader(),
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
                      padding: const EdgeInsets.only(left: 35, top: 20, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logging out...')));
                          signOut().whenComplete(() {
                            if (message == 'success') {
                              isLogOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const user_auth()),
                                  (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message!)));
                            }
                          });
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout,
                              color: Color(0xff32324D),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 10 / 375,
                            ),
                            const Text('Log out',
                                style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ],
                        ),
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
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.APP_PRIMARY_COLOR,
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
                    color: AppColors.APP_PRIMARY_COLOR,
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
                    color: AppColors.APP_PRIMARY_COLOR,
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
                    color: AppColors.APP_PRIMARY_COLOR,
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
                    color: AppColors.APP_PRIMARY_COLOR,
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
            child: Column(
              children: [
                Expanded(
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
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(
                      text: "Add New Preferences ➔",
                      isLoading: isLoading,
                      onPressed: () {
                        UserInformation().updatePreferences(widget.token,
                            {'preferences[0]': ''});
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const WebViewExample()));
                      }),
                ),
              ],
            ),
          );
        });
  }
}
