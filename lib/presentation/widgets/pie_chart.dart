import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/app_colors.dart';

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({
    super.key,
    required this.sections,
    required this.status,
    required this.mainTitle,
  });
  final List<PieChartSectionData>? sections;
  final int status;
  final String mainTitle;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.white,
      height: height * 0.4,
      width: width,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Balance',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  mainTitle,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          PieChart(
            PieChartData(
              startDegreeOffset: 0,
              sectionsSpace: 15,
              centerSpaceRadius: 80,
              sections: sections,
            ),
          ),
        ],
      ),
    );
  }
}
