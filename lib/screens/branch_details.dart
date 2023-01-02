import 'package:flutter/material.dart';
import 'package:SiBuy/models/branch_model.dart';

import '../constant/color_constant.dart';

class BranchDetails extends StatelessWidget {
  const BranchDetails({Key? key, required this.branchData}) : super(key: key);
  final BranchData? branchData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          branchData!.name!,
        ),
        backgroundColor: AppColors.APP_PRIMARY_COLOR,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: SingleChildScrollView(
          // controller: controller,
          child: Column(
            children: [
              // branchData.logo == null
              // ?
              Image.asset('assets/images/kfc.png'),
              // : Image.network(
              //     '${branchData.logoPath}/${branchData.logoPath}'),
              const SizedBox(height: 12),
              ListTile(
                title:
                    Text(branchData!.name ?? 'no name', textScaleFactor: 1.2),
                subtitle: Text(branchData!.address ?? 'no address given'),
              ),
              const SizedBox(height: 20),
              const Text('Description'),
              const SizedBox(height: 8),
              Text(branchData!.description ?? 'no description provided',
                  style: TextStyle(fontSize: 11, color: Colors.grey[400]))
            ],
          ),
        ),
      ),
    );
  }
}
