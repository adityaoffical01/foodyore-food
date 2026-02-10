// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodyore/Auth/User_ragisteration_form.dart';
import 'package:foodyore/Screens/Home/Drawer/drawer.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/All_experiances_widget.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Foodyore_experiance_card.dart';
import 'package:foodyore/Screens/Home/Widget/Categries/Widget/Categry_details_widget.dart';
import 'package:foodyore/Screens/Search/search_screen.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
            _HeroSection(),
            _IntroSection(),
            const SizedBox(height: 16),
            _ExperienceList(key: _experienceKey),
            const SizedBox(height: 10),
            _BottomImage(),
            _BottomContent(onExploreTap: _scrollToExperience),
            _BecomeHostSection(),
            _FoodMemorySection(),
            _FooterSection(),
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

// Hero Section Widget
class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/picture/home_background.png',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        _GradientOverlay(context),
        _TopBar(),
        _HeroText(),
      ],
    );
  }
}

// Bottom Image Widget
class _BottomImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/picture/bottom_background.jpg',
      width: double.infinity,
      height: 400,
      fit: BoxFit.cover,
    );
  }
}

// Intro Section Widget
class _IntroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(color: AppColors.primaryColor),
      child: Text(
        "Dining, the way it was meant to be\n"
        "At Foodyore, food is not served, it is shared. "
        "You step into real spaces, meet real hosts, and experience meals shaped by land, tradition, and people. "
        "This is dining beyond restaurants.\n\n"
        "Foodyore curates immersive dining experiences across India, hosted in homes, farms, villages, "
        "heritage spaces, and open landscapes. "
        "Each experience is personal, limited, and rooted in culture.",
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.regular,
          color: AppColors.white,
        ),
      ),
    );
  }
}

// Bottom Content Widget
class _BottomContent extends StatelessWidget {
  final VoidCallback? onExploreTap;
  const _BottomContent({this.onExploreTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: const BoxDecoration(color: Color(0xff5A4B2D)),
      child: Column(
        children: [
          Text(
            'For those who seek\n more than restaurants',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              fontSize: 28,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Foodyore is for travellers, food lovers, families, and curious minds '
            'who want to connect with culture through food.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              'You don’t just eat here. You belong, even if only for an evening.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.regular,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onExploreTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.white, width: 1),
                ),
              ),
              child: Text(
                'Explore Our Dining Experiences',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.regular,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Become Host Section Widget
class _BecomeHostSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: const BoxDecoration(color: AppColors.white),
      child: Column(
        children: [
          Text(
            'Become a Host',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              fontSize: 28,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Foodyore is for travellers, food lovers, families, and curious minds who want to connect with culture through food.",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
            child: Text(
              "You don’t just eat here.You belong, even if only for an evening.",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.regular,
                color: AppColors.black,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _PrimaryButton('JOIN AS A HOST'),
        ],
      ),
    );
  }
}

// Gradient Overlay Widget
class _GradientOverlay extends StatelessWidget {
  final BuildContext context;
  const _GradientOverlay(this.context);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black26, Colors.black],
          ),
        ),
      ),
    );
  }
}

// Top Bar Widget
class _TopBar extends StatelessWidget {
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

// Hero Text Widget
class _HeroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Column(
        children: [
          Text(
            'Stories served warm',
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Not just a meal. A place,\na story, a shared table.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Get.to(AllExperiancesWidget());
            },
            child: _PrimaryButton('EXPLORE OUR EXPERIENCES'),
          ),
          const SizedBox(height: 8),
          _OutlineButton('BECOME OUR HOST'),
        ],
      ),
    );
  }
}

// Primary Button Widget
class _PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _PrimaryButton(this.title, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.primaryColor),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
            fontFamily: AppFonts.regular,
          ),
        ),
      ),
    );
  }
}

// Outline Button Widget
class _OutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color borderColor;
  const _OutlineButton(
    this.title, {
    this.onTap,
    this.borderColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: borderColor)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: borderColor,
            fontFamily: AppFonts.regular,
          ),
        ),
      ),
    );
  }
}

// Experience List Widget
class _ExperienceList extends StatelessWidget {
  const _ExperienceList({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Explore Our Experience',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () => Get.to(const CategryDetailsWidget()),
              child: const FoodyoreExperianceCard(),
            ),
          ),
        ),
      ],
    );
  }
}

// Food memory section
class _FoodMemorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),

      child: Column(
        children: [
          Text(
            'Because food is memory',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              fontSize: 28,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "The most meaningful meals aren’t \nfound on menus. \nThey are shared in courtyards, farms, \nkitchens, \nand under open skies. \n\nFoodyore exists to protect these experiences and \nbring people together through food.",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// footer section
class _FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: const BoxDecoration(color: Color(0xff5A4B2D)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/icon/logo_icon.png', height: 20),
          SizedBox(height: 15),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Foodyore ',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.regular,
                    color: AppColors.white,
                  ),
                ),
                TextSpan(
                  text:
                      'is a curated experiential dining platform connecting guests with hosts across India. '
                      'Each experience is rooted in place, people, and tradition.',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.regular,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 15),
          Text(
            'About Us',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Contact Us',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Privacy Policy',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Terms and Conditions',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.regular,
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
