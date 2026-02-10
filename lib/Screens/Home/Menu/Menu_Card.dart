import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class MenuCard extends StatelessWidget {
  final String image;
  final String title;

  const MenuCard({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ).copyWith(bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 6),

                      /// PERFECT ALIGNMENT TABLE
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children: const [
                          TableRow(
                            children: [
                              InfoColumn(
                                title: 'MENU TYPE',
                                value: 'Vegetarian',
                              ),
                              InfoColumn(
                                title: 'PACKAGE',
                                value: 'Packages/Bundle',
                              ),
                              InfoColumn(title: 'NO. OF GUESTS', value: '4-20'),
                            ],
                          ),
                          TableRow(
                            children: [
                              SizedBox(height: 6),
                              SizedBox(height: 6),
                              SizedBox(height: 6),
                            ],
                          ),
                          TableRow(
                            children: [
                              InfoColumn(
                                title: 'TOTAL',
                                value: '₹2000 (min. 4)',
                              ),
                              InfoColumn(title: 'PACKAGE', value: '₹1000'),
                              SizedBox(),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // _addToCartButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                'ADD TO CART',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _addToCartButton() {
  //   return Container(
  //     // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     decoration: BoxDecoration(
  //       color: AppColors.primaryColor,
  //       borderRadius: BorderRadius.circular(44),
  //     ),
  //     child: Text(
  //       'ADD TO CART',
  //       style: AppTextStyles.caption.copyWith(
  //         color: AppColors.white,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }
}

// for info column
class InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const InfoColumn({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.caption.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
