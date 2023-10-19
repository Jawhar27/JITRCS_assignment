import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/app_colors.dart';

class TransactionIcon extends StatelessWidget {
  const TransactionIcon({
    super.key,
    this.fontSize,
    this.height,
    this.width,
  });

  final double? fontSize;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.08,
      width: width ?? MediaQuery.of(context).size.width * 0.12,
      color: AppColors.kPrimaryColor,
      child: Center(
        child: Text(
          'T',
          style: TextStyle(
            fontSize: fontSize ?? 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
