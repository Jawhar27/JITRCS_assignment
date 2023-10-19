import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelTextField extends StatelessWidget {
  const LabelTextField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.validator,
    this.focusNode,
    this.focusNext,
    this.onEditingComplete,
    this.prefixWidget,
    this.inputType = TextInputType.text,
    this.onChanged,
    this.customHeight,
    this.readOnly = false,
    this.maxLength,
    this.inputFormatters = const [],
    this.borderCircularSize = 15.0,
    this.isPasswordField = false,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final FocusNode? focusNext;
  final Function()? onEditingComplete;
  final Widget? prefixWidget;
  final TextInputType inputType;
  final void Function(String)? onChanged;
  final double? customHeight;
  final bool readOnly;
  final int? maxLength;
  final List<TextInputFormatter> inputFormatters;
  final double borderCircularSize;
  final bool isPasswordField;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: customHeight,
      width: ScreenUtil.defaultSize.width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(
          borderCircularSize,
        ),
        color: AppColors.white,
      ),
      child: SizedBox(
        width: ScreenUtil.defaultSize.width,
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            readOnly: readOnly,
            obscureText: isPasswordField,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
            focusNode: focusNode,
            keyboardType: inputType,
            onEditingComplete: () {
              focusNode?.unfocus();
              if (focusNext != null) {
                focusNext!.requestFocus();
              }
              if (onEditingComplete != null) {
                onEditingComplete!();
              }
            },
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sp),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sp),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sp),
                borderSide: BorderSide.none,
              ),
              // focusedErrorBorder: InputBorder.none,
              // errorBorder: InputBorder.none,
              fillColor: Theme.of(context).colorScheme.onSecondary,
              filled: true,
              prefix: prefixWidget,
              suffixIcon:  suffixIcon ,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: AppColors.hintColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            controller: controller,
            validator: validator,
            maxLength: maxLength,
          ),
        ),
      ),
    );
  }
}
