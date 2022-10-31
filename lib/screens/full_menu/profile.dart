import 'package:SiBuy/screens/full_menu/add_deal.dart';
import 'package:SiBuy/user_app/user_menu/change_pass.dart';
import 'package:flutter/material.dart';
import 'package:SiBuy/models/branch_model.dart';
import 'package:SiBuy/models/merchant_profile_model.dart';
import 'package:SiBuy/screens/active_deals.dart';
import 'package:SiBuy/services/branch/branch_services.dart';
import 'package:SiBuy/services/get_profile/get_user_info.dart';
import 'package:SiBuy/user_app/splash_screen/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/api_urls.dart';
import '../../services/auth/authentication.dart';

import '../../support/contact.dart';
import '../../support/support.dart';
import '../../user_app/user_auth/user_auth.dart';
import '../my_branches.dart';
import 'all_offers.dart';
import 'request_pay.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.token, this.isLeadingIcon = false})
      : super(key: key);
  final String token;
  final bool isLeadingIcon;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  String? title;
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.isLeadingIcon == true)
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                        size: 20,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: FutureBuilder<ProfileModel>(
                    future:
                        UserInformation().getMerchantInformation(widget.token),
                    builder: (context, snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        var data = snapshot.data!.data!;

                        // print(int.parse(data.averageRating.toString()));
                        children = <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffff6000),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 13, bottom: 10),
                                          child: Text(data.name!,
                                              style: const TextStyle(
                                                  fontFamily: 'DMSans',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff32324D))),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('${data.branches![0].address}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: 'DMSans',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('${data.phone}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: 'DMSans',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('${data.email}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: 'DMSans',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                    Container(
                                      child: data.profilePicture == null ||
                                              data.profilePicture!.isEmpty
                                          ? Image.asset(
                                              'assets/images/kfc.png',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  70 /
                                                  812,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  70 /
                                                  375,
                                            )
                                          : CircleAvatar(
                                              radius: 70,
                                              backgroundImage: NetworkImage(
                                                  '${ApiUrls.imgBaseUrl}${data.profilePicturePath}/${data.profilePicture}'),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                      return SizedBox(
                        width: double.maxFinite,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: children),
                      );
                    },
                  ),
                ),
                Spacer(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ActiveMerchantDeals(token: widget.token)));
                  },
                  title: const Text("Active Offers",
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff32324D))),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => All_offer()));
                    // branches().whenComplete(() =>
                    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //         content: Text(
                    //             'number of branches: ${allBranches!.data!.length}'))));
                  },
                  leading: const Text("All Offer",
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff32324D))),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyBranches(token: widget.token)));
                    // branches().whenComplete(() =>
                    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //         content: Text(
                    //             'number of branches: ${allBranches!.data!.length}'))));
                  },
                  leading: const Text("My Branches",
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff32324D))),
                ),
                // ListTile(
                //   onTap: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (_) => Support(token: widget.token)));
                //   },
                //   title: const Text(
                //     "Support",
                //     style: TextStyle(
                //       fontFamily: 'Mulish',
                //       fontSize: 12,
                //       fontWeight: FontWeight.w600,
                //       color: Color(0xff32324D),
                //     ),
                //   ),
                // ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Add_deal()));
                    // branches().whenComplete(() =>
                    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //         content: Text(
                    //             'number of branches: ${allBranches!.data!.length}'))));
                  },
                  leading: const Text("Add New Offer",
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff32324D))),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Change_pass()));
                    // branches().whenComplete(() =>
                    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //         content: Text(
                    //             'number of branches: ${allBranches!.data!.length}'))));
                  },
                  leading: const Text("Change Password",
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff32324D))),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Request_pay()));
                    // branches().whenComplete(() =>
                    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //         content: Text(
                    //             'number of branches: ${allBranches!.data!.length}'))));
                  },
                  leading: const Text("Request Payment",
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff32324D))),
                ),
                // const Spacer(),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logging out...')));
                    MerchantAuthServices().logOut(widget.token).then((value) {
                      if (value == 'success') {
                        isLogOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const user_auth()),
                            (route) => false);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(value)));
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: const [
                        Text(
                          'Log out',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff9E9E9E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
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

  AllBranches? allBranches;

  Future<void> branches() async {
    final result = await BranchServices().getAllBranches(token: widget.token);
    allBranches = result;
    print(allBranches!.message);
  }
}
