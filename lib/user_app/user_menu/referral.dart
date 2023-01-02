import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../constant/app_styles.dart';
import '../../constant/color_constant.dart';
import '../../models/referral_model.dart';
import '../../models/wish_list_model.dart';
import '../../providers/deal_provider.dart';
import '../../shared/loader.dart';

class Referral extends StatefulWidget {
  Referral({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<Referral> createState() => _ReferralState();
}

class _ReferralState extends State<Referral> {

  bool isLoading = true;
  DealProvider? _provider;
  String referralCode = '';

  @override
  void initState() {
    _provider = Provider.of<DealProvider>(context, listen: false);
    _provider?.getReferral(widget.token).then((value){
      referralCode = _provider!.referrals!.referralCode!;
      isLoading = false;
      setState(() { });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.APP_PRIMARY_COLOR,
        title: const Text('Referral'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset('assets/images/ref.png'),
          const SizedBox(
            height: 20,
          ),
          //Text with bold font
          Text(
            'SiBuy/${referralCode}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.APP_PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Copy Link',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Share.share('Hey! Join SiBuy using my Referral Code: $referralCode');
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.APP_PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Share Link',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'My Referrals',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF32324D),
              ),
            ),
          ),
          Expanded(child: isLoading ? Loader() : _provider!.referrals!.users!.isEmpty ? const Center(
          child: Text(
          'No Referrals Yet',
            style: TextStyle(
              fontFamily: 'Mulish',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF32324D),
            ),
          )) : ListView.separated(
              itemCount: _provider!.referrals!.users!.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const Padding(
                      padding: EdgeInsets.only(top: 18, bottom: 18),
                      child: Divider(
                        color: Color(0xFFE6E6E6),
                        thickness: 0.5,
                        // height: 214,
                        indent: 26,
                        endIndent: 26,
                      )
                  );
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFE8E8E8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ${_provider!.referrals!.users![index].name!}'),
                          Insets.gapH10,
                          Text('Joined Date: ${_provider!.referrals!.users![index].date!}')
                        ],
                      ),
                    ),
                  );
                }),
              )
        ],
      ),
    );
  }
}