import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_dottedline.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class CartItemCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onToggle;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.isSelected,
    required this.onToggle,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white),
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/pre-wedding-shoot-in-lucknow.jpg',
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 1, 175, 1),
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.circle,
                                size: 8,
                                color: Color.fromARGB(255, 1, 175, 1),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'ORD-123456',
                              style: AppTextStyles.bodySmall.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.regular,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: onRemove,
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Chicken Roti Rice sala unlimited with extra cheese and extra chicken pieces',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Per Person',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.grey,
                                    fontFamily: AppFonts.regular,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Price : ${AppContent().moneySymbol}250/-',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.grey,
                                    fontFamily: AppFonts.regular,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            _QtySelector(
                              onIncrease: onIncrease,
                              onDecrease: onDecrease,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// ✅ Rounded checkbox
              Positioned(
                top: 5,
                left: 5,
                child: InkWell(
                  onTap: onToggle,
                  child: Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),

                      color: isSelected ? AppColors.primaryColor : Colors.white,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    child: isSelected
                        ? Icon(
                            CupertinoIcons.check_mark,
                            size: 12,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomDottedDivider(color: AppColors.primaryColor),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${AppContent().moneySymbol}250/-',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.regular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//qty
class _QtySelector extends StatelessWidget {
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const _QtySelector({required this.onIncrease, required this.onDecrease});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 1.2),
        borderRadius: BorderRadius.circular(66),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onDecrease,
            child: Icon(Icons.remove, color: AppColors.primaryColor),
          ),
          Text(
            '1',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.regular,
            ),
          ),
          GestureDetector(
            onTap: onIncrease,
            child: Icon(Icons.add, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
