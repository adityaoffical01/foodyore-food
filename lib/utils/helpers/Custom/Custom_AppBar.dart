import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  const CustomAppbar({Key? key, required this.title, this.subTitle})
    : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Iconsax.arrow_left_2_copy, color: AppColors.white),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Column(
        children: [
          Text(
            title,
            style: AppTextStyles.headingSmall.copyWith(color: AppColors.white),
          ),
          subTitle != null
              ? Text(
                  subTitle!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: AppTextStyles.caption.copyWith(color: AppColors.white),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
