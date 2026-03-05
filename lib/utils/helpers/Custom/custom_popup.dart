import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class CustomPopup {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    String cancelButtonText = 'Cancel',
    String submitButtonText = 'Submit',
    VoidCallback? onCancel,
    VoidCallback? onSubmit,
    Color submitButtonColor = AppColors.primaryColor,
    Color? cancelButtonColor,
    double? height,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: height ?? 150,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.backgroundColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.headingMedium.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      message,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onCancel != null) onCancel();
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, 32),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        cancelButtonText,
                        style: TextStyle(
                          color: cancelButtonColor ?? AppColors.grey,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onSubmit != null) onSubmit();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: submitButtonColor,
                        minimumSize: const Size(0, 32),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        submitButtonText,
                        style: AppTextStyles.buttonText.copyWith(
                          color: AppColors.white,
                          fontFamily: AppFonts.regular,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
