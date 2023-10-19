import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/app_colors.dart';
import 'package:jitrcs_assignment/data_sources/transaction_data.dart';
import 'package:jitrcs_assignment/models/transaction.dart';
import 'package:jitrcs_assignment/presentation/layouts/main_layout.dart';
import 'package:jitrcs_assignment/presentation/providers/data_provider.dart';
import 'package:jitrcs_assignment/presentation/widgets/common_button.dart';
import 'package:jitrcs_assignment/presentation/widgets/transaction_icon.dart';
import 'package:jitrcs_assignment/utils/alert_util.dart';
import 'package:jitrcs_assignment/utils/navigation_util.dart';

class TransactionDetailScreen extends StatefulWidget {
  const TransactionDetailScreen({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MainLayout(
      loading: _loading,
      appBarText: 'Transaction Detail',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TransactionIcon(
            height: size.height * 0.2,
            width: size.width * 0.4,
            fontSize: 40.sp,
          ),
          Column(
            children: [
              _titleAndValue(
                  'Transaction Date :- ', widget.transaction.transactionDate!),
              SizedBox(
                height: 20.h,
              ),
              _titleAndValue('Transaction Amount :- ',
                  'RS ${widget.transaction.transactionAmount!}'),
              SizedBox(
                height: 20.h,
              ),
              _titleAndValue(
                  'Comission :- ', 'RS ${widget.transaction.comission!}'),
              SizedBox(
                height: 20.h,
              ),
              _titleAndValue('Total :- ', 'RS ${widget.transaction.total!}'),
              SizedBox(
                height: 20.h,
              ),
              _titleAndValue('Transaction Number :- ',
                  widget.transaction.transactionNumber!),
              SizedBox(
                height: 20.h,
              ),
              _titleAndValue(
                  'Type of Operation :- ', widget.transaction.typeOfOperation!),
            ],
          ),
          Center(
            child: CommonButton(
              width: size.width * 0.5,
              backgroundColor: Colors.red,
              buttonText: 'Cancel',
              onPressed: () {
                showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SizedBox(
                          height: size.height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Are you sure you want to Delete this Transaction?',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CommonButton(
                                    buttonTextStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.white,
                                    ),
                                    height: size.height * 0.05,
                                    width: size.width * 0.3,
                                    buttonText: 'No',
                                    backgroundColor: Colors.greenAccent,
                                    onPressed: () {
                                      popScreen(context);
                                    },
                                  ),
                                  CommonButton(
                                    buttonTextStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.white,
                                    ),
                                    height: size.height * 0.05,
                                    width: size.width * 0.3,
                                    buttonText: 'Yes, Delete',
                                    backgroundColor: AppColors.red,
                                    onPressed: () async {
                                      popScreen(context);
                                      setState(() {
                                        _loading = true;
                                      });
                                      await getDataProviderState(context)
                                          .deleteTransaction(
                                              widget.transaction.id!)
                                          .then((value) => _showSuccess());
                                      setState(() {
                                        _loading = false;
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  _showSuccess() {
    return showFailedDialog(
        barrierDismissible: false,
        context: context,
        isSuccess: true,
        message: 'Transaction deleted successfully!',
        onPressed: () {
          popScreen(context);
          popScreen(
            context,
            result: 'success',
          );
        });
  }

  _titleAndValue(
    String title,
    String value,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700),
        ),
        Text(
          value,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
