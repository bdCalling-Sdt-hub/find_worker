import 'package:find_worker/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedLoadingButton extends StatelessWidget {

  final Color titleColor;
  final Color buttonColor;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth;

  const CustomElevatedLoadingButton({
    this.titleColor = AppColors.white,
    this.buttonColor = AppColors.blue_100,
    this.buttonRadius = 12,
    this.buttonHeight = 60,
    this.buttonWidth,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: (){},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
                side: const BorderSide(color: AppColors.blue_100, width: 1.0),
              ),
            ),
            elevation: MaterialStateProperty.all(0)),
        child: const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
