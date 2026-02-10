// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class AboutusWidget extends StatefulWidget {
  const AboutusWidget({Key? key}) : super(key: key);

  @override
  State<AboutusWidget> createState() => _AboutusWidgetState();
}

class _AboutusWidgetState extends State<AboutusWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _images = const [
    'assets/images/formland.jpg',
    'assets/images/formland.jpg',
    'assets/images/formland.jpg',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Experiences of serenity, shared through food'),
                  _sectionBody(
                    "Foodyore is a curated experiential dining platform that brings people together through food, place, and tradition. We work closely with hosts across farms, villages, heritage homes, princely estates, and open landscapes to create dining experiences that are deeply rooted in their surroundings. Each experience reflects the unique character of its location — the food, the people, the stories, and the way meals are shared. At Foodyore, dining is not just about what is served on the table. It is about where the meal takes place, who prepares it, and the cultural context that shapes it. We believe that food carries memory, history, and emotion, and that the most meaningful meals are those experienced slowly and shared with intention.",
                  ),
                  const SizedBox(height: 20),

                  _sectionTitle('What We Do'),
                  _sectionBody(
                    "We identify authentic destinations and hosts who are willing to open their spaces and tables to guests. Every experience is carefully reviewed and curated to ensure it reflects the values of hospitality, cultural integrity, and respect for place. Our role is to bridge the gap between hosts and guests — bringing together people who value meaningful experiences over commercial dining. We focus on small-group experiences that allow genuine interaction, participation, and appreciation.",
                  ),
                  const SizedBox(height: 20),

                  _sectionTitle('Our Philosophy'),
                  _sectionBody(
                    "Foodyore was built on the belief that true experiences are born from desire — the desire to explore, to connect, and to step away from routine life. Whether it is a royal meal in a heritage home, a farm-based feast prepared with freshly harvested ingredients, or a village kitchen where recipes have been passed down through generations, each experience is designed to feel personal and grounded. We call these experiences of serenity — moments where food, place, and people come together naturally.",
                  ),
                  const SizedBox(height: 20),

                  _sectionTitle('Our Commitment'),
                  _sectionBody(
                    "We are committed to curating experiences that honour local culture, support hosts, and offer guests a sense of connection that goes beyond the plate. Every experience listed on Foodyore is thoughtfully selected to ensure it delivers value, trust, and lasting memories.",
                  ),
                  const SizedBox(height: 20),

                  Text(
                    'Gallery',
                    style: AppTextStyles.headingSmall.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildImageSlider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- UI PARTS --------------------

  PreferredSizeWidget _buildAppBar() {
    return CustomAppbar(title: 'About Foodyore');
  }

  Widget _buildHeaderImage() {
    return Image.asset(
      'assets/picture/aboutus.jpg',
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryColor),
    );
  }

  Widget _sectionBody(String text) {
    return Text(
      text,
      style: AppTextStyles.caption.copyWith(
        color: AppColors.black,
        fontFamily: AppFonts.regular,
      ),
    );
  }

  Widget _buildImageSlider() {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (_, index) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                _images[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),

        /// Page Indicator
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _images.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                width: _currentIndex == index ? 18 : 6,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? AppColors.primaryColor
                      : AppColors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
