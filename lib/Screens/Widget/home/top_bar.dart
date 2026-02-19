import 'package:flutter/material.dart';
import 'package:foodyore/Auth/User_ragisteration_form.dart';
import 'package:foodyore/Screens/Search/search_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Iconsax.menu_1_copy, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          Image.asset('assets/icon/logo_icon.png', height: 40, width: 80),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Iconsax.search_normal_copy,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.to(const SearchScreen());
                },
              ),
              IconButton(
                icon: const Icon(Iconsax.user_copy, color: Colors.white),
                onPressed: () {
                  Get.to(const UserRagisterationWidget(isFromProfile: true));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
