// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodyore/Screens/Home/Drawer/drawer.dart';
import 'package:foodyore/Screens/Widget/home/bottom_content.dart';
import 'package:foodyore/Screens/Widget/home/bottom_host_section.dart';
import 'package:foodyore/Screens/Widget/home/bottom_image.dart';
import 'package:foodyore/Screens/Widget/home/experience_list.dart';
import 'package:foodyore/Screens/Widget/home/food_memory_section.dart';
import 'package:foodyore/Screens/Widget/home/footer_section.dart';
import 'package:foodyore/Screens/Widget/home/hero_section.dart';
import 'package:foodyore/Screens/Widget/home/intro_section.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _experienceKey = GlobalKey();

  void _scrollToExperience() {
    final context = _experienceKey.currentContext;
    if (context == null) return;

    final RenderObject renderObject = context.findRenderObject()!;
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(
      renderObject,
    );

    final offset = viewport.getOffsetToReveal(renderObject, 0.0).offset;

    _scrollController.animateTo(
      offset - 80, // little top padding
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: buildDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            HeroSection(),
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
    );
  }
}
