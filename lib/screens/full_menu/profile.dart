import 'package:flutter/material.dart';
import 'package:gigi_app/models/branch_model.dart';
import 'package:gigi_app/models/merchant_profile_model.dart';
import 'package:gigi_app/screens/active_deals.dart';
import 'package:gigi_app/services/branch/branch_services.dart';
import 'package:gigi_app/services/get_profile/get_user_info.dart';
import 'package:gigi_app/user_app/splash_screen/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/api_urls.dart';
import '../../services/auth/authentication.dart';

import '../../support/support.dart';
import '../my_branches.dart';

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
                  child: FutureBuilder<ProfileModel>(
                    future:
                        UserInformation().getMerchantInformation(widget.token),
                    builder: (context, snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        var data = snapshot.data!.data!;

                        // print(int.parse(data.averageRating.toString()));
                        children = <Widget>[
                          Container(
                            child: data.profilePicture == null ||
                                    data.profilePicture!.isEmpty
                                ? Image.asset('assets/images/kfc.png')
                                : CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(
                                        '${ApiUrls.imgBaseUrl}${data.profilePicturePath}/${data.profilePicture}'),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 13, bottom: 10),
                            child: Text(data.name!,
                                style: const TextStyle(
                                    fontFamily: 'DMSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff32324D))),
                          ),
                          Text(
                              '${data.branches![0].address}\n${data.phone}  | ${data.email}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffC5C5C5))),
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
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: children),
                      );
                    },
                  ),
                ),
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
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Support(token: widget.token)));
                  },
                  title: const Text(
                    "Support",
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff32324D),
                    ),
                  ),
                ),
                const Spacer(),
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
                                builder: (_) => const SplashScreen()),
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
