import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/assets.dart';
import 'package:jitrcs_assignment/config/routes.dart';
import 'package:jitrcs_assignment/data_sources/db_helper.dart';
import 'package:jitrcs_assignment/presentation/widgets/transaction_icon.dart';
import 'package:jitrcs_assignment/utils/navigation_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    DBHelper.deleteTable();
    DBHelper.createTable().then((value) {
      DBHelper.insertTransaction();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(
            const Duration(
              seconds: 3,
            ), () {
          moveToScreen(
            context,
            ScreenRoutes.toSignInScreen,
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: TransactionIcon(
          height: size.height * 0.3,
          width: size.width * 0.5,
          fontSize: 70.sp,
        ),
      ),
    );
  }
}
