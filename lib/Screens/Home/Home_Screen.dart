// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodyore/Auth/Controller/Auth_Controller.dart';
import 'package:foodyore/Screens/Home/Drawer/drawer.dart';
import 'package:foodyore/Screens/Widget/home/bottom_content.dart';
import 'package:foodyore/Screens/Widget/home/bottom_host_section.dart';
import 'package:foodyore/Screens/Widget/home/bottom_image.dart';
import 'package:foodyore/Screens/Widget/home/experience_list.dart';
import 'package:foodyore/Screens/Widget/home/food_memory_section.dart';
import 'package:foodyore/Screens/Widget/home/footer_section.dart';
import 'package:foodyore/Screens/Widget/home/hero_section.dart';
import 'package:foodyore/Screens/Widget/home/intro_section.dart';
import 'package:foodyore/controller/category_controller.dart';
import 'package:foodyore/services/app_config.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final CategoryController _catController = Get.put(CategoryController());
  final AuthController _authController = Get.put(AuthController());

  final GlobalKey _experienceKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _catController.fetchCategories(context);
    _authController.getProfile(userId);
  }

  void _scrollToExperience() {
    final context = _experienceKey.currentContext;
    if (context == null) return;

    final RenderObject renderObject = context.findRenderObject()!;
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(
      renderObject,
    );

    final offset = viewport.getOffsetToReveal(renderObject, 0.0).offset;

    _scrollController.animateTo(
      offset - 80,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: buildDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => _catController.fetchCategories(context),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              HeroSection(onExploreTap: _scrollToExperience),
              IntroSection(),
              const SizedBox(height: 16),
              ExperienceList(key: _experienceKey),
              const SizedBox(height: 10),
              BottomImage(),
              BottomContent(onExploreTap: _scrollToExperience),
              BecomeHostSection(),
              FoodMemorySection(),
              FooterSection(),
              const SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '©  Foodyore',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.regular,
                        color: AppColors.black,
                      ),
                    ),
                    TextSpan(
                      text: '  All rights reserved.',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.regular,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
