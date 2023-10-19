import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/app_colors.dart';
import 'package:jitrcs_assignment/config/constants.dart';

class CustomTabLayout extends StatelessWidget {
  const CustomTabLayout({
    super.key,
    this.initialIndex = 0,
    this.tabIndex = 0,
    this.onTap,
    required this.noOfTabs,
    required this.tab1,
    required this.tab2,
    required this.child1,
    required this.child2,
    this.customHeight,
    this.tabFontSize,
    this.isScrollableTabbar = false,
    this.isPaddingNeededForTabBar = false,
    this.tabBarBackgroundColor,
  });
  final int tabIndex;
  final int initialIndex;
  final void Function(int)? onTap;
  final Widget child1;
  final Widget child2;
  final int noOfTabs;
  final String tab1;
  final String tab2;
  final double? customHeight;
  final double? tabFontSize;

  final bool isScrollableTabbar;
  final bool isPaddingNeededForTabBar;
  final Color? tabBarBackgroundColor;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: noOfTabs,
      initialIndex: initialIndex,
      child: SizedBox(
        height: customHeight ?? height * 0.8,
        width: width,
        child: Column(
          children: [
            Container(
              color: tabBarBackgroundColor,
              padding: isPaddingNeededForTabBar
                  ? EdgeInsets.only(
                      left: ScreenPadding.defaultPadding,
                      right: ScreenPadding.defaultPadding,
                    )
                  : null,
              height: 50.h,
              width: width,
              child: TabBar(
                isScrollable: isScrollableTabbar,
                onTap: onTap,
                labelColor: Colors.black45,
                tabs: [
                  _tabItem(
                    tabName: tab1,
                    context: context,
                    isActivated: tabIndex == 0,
                  ),
                  _tabItem(
                    tabName: tab2,
                    context: context,
                    isActivated: tabIndex == 1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  child1,
                  child2,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _tabItem({
    required String tabName,
    required BuildContext context,
    bool isActivated = false,
    bool withContainer = false,
  }) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FittedBox(
      child: Text(
        tabName,
        style: TextStyle(
          color: isActivated ? AppColors.kPrimaryColor : AppColors.black,
          fontSize: tabFontSize ?? 14.sp,
        ),
      ),
    );
  }
}
