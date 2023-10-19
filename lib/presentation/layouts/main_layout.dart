import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/app_colors.dart';
import 'package:jitrcs_assignment/config/constants.dart';
import 'package:jitrcs_assignment/utils/navigation_util.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    super.key,
    this.appBarText,
    this.isScrollable = false,
    required this.child,
    this.loading = false,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = false,
    this.isBackArrowNeeded = false,
  });

  final String? appBarText;
  final bool isScrollable;
  final Widget child;
  final bool loading;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool isBackArrowNeeded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.white,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBarText != null
          ? AppBar(
              backgroundColor: AppColors.white,
              centerTitle: true,
              elevation: 0.0,
              title: Text(
                appBarText ?? "",
                style: TextStyle(
                  fontSize: 17.sp,
                ),
              ),
              leading: isBackArrowNeeded
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        popScreen(context);
                      },
                    )
                  : null,
            )
          : null,
      body: Stack(
        children: [
          Container(
            color: backgroundColor,
            padding: EdgeInsets.only(
              left: ScreenPadding.defaultPadding,
              right: ScreenPadding.defaultPadding,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: !isScrollable
                            ? child
                            : SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: child,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: loading,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
