// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Foodyore_experiance_card.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Widget/Categry_details_widget.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';

class AllExperiancesWidget extends StatelessWidget {
  const AllExperiancesWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(title: 'All Categries'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                Text(
                  'Explore our experiences',
                  style: AppTextStyles.headingSmall,
                ),
                Text(
                  'Discover curated dining experiences hosted across India, each rooted in place, culture, and tradition.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(color: AppColors.black),
                ),
                SizedBox(height: 10.0),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Get.to(CategryDetailsWidget()),
                      child: FoodyoreExperianceCard( imgUrls: "", tittle: "",),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
