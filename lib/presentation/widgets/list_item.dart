import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/app_colors.dart';
import 'package:jitrcs_assignment/config/constants.dart';
import 'package:jitrcs_assignment/presentation/widgets/transaction_icon.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.amount,
    required this.transactionType,
    required this.transactionNumber,
    required this.onTap,
    this.amountColor,
  });

  final String transactionType;
  final String transactionNumber;
  final String amount;
  final void Function()? onTap;
  final Color? amountColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: ScreenPadding.paddingHeight16,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12.0,
            ),
            border: Border.all(
              width: 1,
              color: AppColors.borderColor,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const TransactionIcon(),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          transactionType,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          transactionNumber,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      amount,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: amountColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
