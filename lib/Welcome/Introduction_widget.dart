// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodyore/Welcome/Welcome_widget.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.to(WelcomeWidget(), transition: Transition.fadeIn);
    }
  }

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/chef.png',
      'title': 'Discover Authentic Culinary Experiences',
      'description':
          'Home-style meals, heritage kitchens & local food journeys',
    },
    {
      'image': 'assets/images/intro-2.png',
      'title': 'Explore by Taste, Place & Culture',
      'description': 'Find unique food experiences near you and across India',
    },
    {
      'image': 'assets/images/intro-3.png',
      'title': 'Create Memories, Not Just Meals',
      'description': 'Meet local hosts, share stories & taste real traditions',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingData.length,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        itemBuilder: (context, index) => OnboardingPage(
          index: index,
          image: onboardingData[index]['image']!,
          title: onboardingData[index]['title']!,
          description: onboardingData[index]['description']!,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: GestureDetector(
            onTap: _nextPage,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: (_currentPage + 1) / onboardingData.length,
                    strokeWidth: 2.0,
                    backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == onboardingData.length - 1
                        ? AppColors.primaryColor
                        : AppColors.primaryColor,
                  ),
                  child: _currentPage == onboardingData.length - 1
                      ? Text('GO', style: TextStyle(color: AppColors.white))
                      : Icon(
                          CupertinoIcons.chevron_right,
                          size: 20,
                          color: AppColors.backgroundColor,
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image, title, description;
  final int index;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height / 4),
        Image.asset(image, height: 400, width: 250, fit: BoxFit.contain),
        const Spacer(),
        Text(
          title,
          style: TextStyle(
            fontFamily: AppFonts.primaryFont,
            fontSize: AppSizes.semiLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.regular,
              fontSize: AppSizes.medium,
              height: 1.2,
              color: Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
