import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/app_colors.dart';
import 'package:jitrcs_assignment/config/assets.dart';
import 'package:jitrcs_assignment/config/text_styles.dart';
import 'package:jitrcs_assignment/presentation/widgets/common_button.dart';

Future<void> showFailedDialog({
  required BuildContext context,
  String title = "Failed !",
  bool isSuccess = false,
  String? message,
  String? buttonText,
  bool? barrierDismissible,
  required void Function() onPressed,
}) async {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return await showDialog<void>(
    barrierDismissible: barrierDismissible ?? false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 0,
          backgroundColor: AppColors.white,
          child: Container(
            height: height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Image.asset(
                        isSuccess ? success : warning,
                        width: width * 0.15,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        isSuccess ? 'Success' : title,
                        style: TextStyle(
                            color: isSuccess ? Colors.green : AppColors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
                      Text(
                        message ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 166, 166, 166),
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                CommonButton(
                  width: width * 0.6,
                  buttonText: buttonText ?? "OK",
                  onPressed: onPressed,
                ),
              ],
            ),
          ));
    },
  );
}
