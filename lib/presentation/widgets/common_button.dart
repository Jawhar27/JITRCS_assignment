import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/app_colors.dart';
import 'package:jitrcs_assignment/config/text_styles.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.buttonText,
    this.buttonTextStyle,
    this.backgroundColor,
    this.height,
    required this.onPressed,
    this.width,
  });
  final String buttonText;
  final TextStyle? buttonTextStyle;
  final Color? backgroundColor;
  final double? height;
  final void Function()? onPressed;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? ScreenUtil.defaultSize.width,
      height: height ?? 50.h,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 2,
            backgroundColor: backgroundColor ?? AppColors.kPrimaryColor,
          ),
          child: Text(
            buttonText,
            style: buttonTextStyle ?? TextStyles.signInButtonText,
          )),
    );
  }
}
