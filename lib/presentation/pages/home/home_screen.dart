import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitrcs_assignment/config/app_colors.dart';
import 'package:jitrcs_assignment/config/constants.dart';
import 'package:jitrcs_assignment/config/routes.dart';
import 'package:jitrcs_assignment/data_sources/db_helper.dart';
import 'package:jitrcs_assignment/models/transaction.dart';
import 'package:jitrcs_assignment/presentation/layouts/main_layout.dart';
import 'package:jitrcs_assignment/presentation/providers/data_provider.dart';
import 'package:jitrcs_assignment/presentation/widgets/custom_tabbar.dart';
import 'package:jitrcs_assignment/presentation/widgets/list_item.dart';
import 'package:jitrcs_assignment/presentation/widgets/pie_chart.dart';
import 'package:jitrcs_assignment/utils/log_util.dart';
import 'package:jitrcs_assignment/utils/navigation_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  Future<List<Transaction>>? _getAllTransaction;

  @override
  void initState() {
    _getAllTransaction = _getTransactions();

    super.initState();
  }

  Future<List<Transaction>> _getTransactions() async {
    final transactions =
        await getDataProviderState(context).fetchTransactionData();
    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarText: 'Transactions',
      isBackArrowNeeded: false,
      child: CustomTabLayout(
        noOfTabs: 2,
        isPaddingNeededForTabBar: false,
        tabIndex: selectedIndex,
        initialIndex: 0,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        tab1: 'Transactions',
        tab2: 'Diagram View',
        child1: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: ScreenPadding.paddingHeight12,
                ),
                child: FutureBuilder(
                    future: _getAllTransaction,
                    builder: (context, snapshot) {
                      Widget futureWidget = Container();
                      if (snapshot.hasData) {
                        futureWidget = (snapshot.data?.isEmpty ?? true)
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: Center(
                                  child: Text(
                                    'No Transactions found !',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  Transaction transaction =
                                      snapshot.data![index];
                                  return ListItem(
                                    amount: transaction.transactionAmount!
                                        .toString(),
                                    transactionType:
                                        transaction.transactionType!,
                                    transactionNumber:
                                        transaction.transactionNumber!,
                                    amountColor: transaction.transactionType ==
                                            'Withdrawal'
                                        ? Colors.red
                                        : transaction.transactionType ==
                                                'Deposit'
                                            ? Colors.green
                                            : Colors.blue,
                                    onTap: () async {
                                      final result = await pushScreen(
                                          context,
                                          ScreenRoutes
                                              .toTransactionDetailScreen,
                                          arguments: {
                                            'transaction': transaction,
                                          });
                                      if (result != null) {
                                        setState(() {
                                          _getAllTransaction =
                                              _getTransactions();
                                        });
                                      }
                                    },
                                  );
                                },
                              );
                      } else if (snapshot.hasError) {
                        futureWidget = SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Center(
                            child: Text(
                              snapshot.error.toString(),
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        );
                      } else {
                        futureWidget = SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return futureWidget;
                    }),
              ),
            ),
            SizedBox(
              height: ScreenPadding.paddingHeight12,
            ),
          ],
        ),
        child2: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: _getAllTransaction,
              builder: (context, snapshot) {
                double replenishmentAmount = 0.0;
                double withdrawalAmount = 0.0;
                double transferAmount = 0.0;
                double balanceAmount = 0.0;
                Widget futureWidget = Container();
                if (snapshot.hasData) {
                  if (snapshot.data?.isNotEmpty ?? false) {
                    snapshot.data?.forEach((element) {
                      if (element.typeOfOperation == 'Replenishment') {
                        replenishmentAmount =
                            replenishmentAmount + element.transactionAmount!;
                      } else if (element.typeOfOperation == 'Withdrawal') {
                        withdrawalAmount =
                            withdrawalAmount + element.transactionAmount!;
                      } else {
                        transferAmount =
                            transferAmount + element.transactionAmount!;
                      }
                    });
                    balanceAmount = replenishmentAmount -
                        (transferAmount + withdrawalAmount);
                  }
                  futureWidget = Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 60.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomPieChart(
                            mainTitle: 'RS $balanceAmount',
                            status: 1,
                            sections: [
                              PieChartSectionData(
                                value: transferAmount,
                                color: Colors.blue,
                                radius: 40,
                                showTitle: true,
                                title: 'Transfer',
                                titleStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                                titlePositionPercentageOffset: 2,
                              ),
                              PieChartSectionData(
                                value: withdrawalAmount,
                                color: Colors.red,
                                radius: 40,
                                showTitle: true,
                                title: 'Withdrawal',
                                titleStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                                titlePositionPercentageOffset: 2,
                              ),
                              PieChartSectionData(
                                value: replenishmentAmount,
                                color: Colors.green,
                                radius: 40,
                                showTitle: true,
                                title: 'Replenishment',
                                titleStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                                titlePositionPercentageOffset: 2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                          Column(
                            children: [
                              _pieChartDetail(
                                'Replenishment',
                                Colors.green,
                                replenishmentAmount,
                              ),
                              _pieChartDetail(
                                'Withdrawal',
                                Colors.red,
                                withdrawalAmount,
                              ),
                              _pieChartDetail(
                                'Transfer',
                                Colors.blue,
                                transferAmount,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return futureWidget;
              }),
        ),
      ),
    );
  }

  _pieChartDetail(String amountType, Color color, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 20.h,
          width: 20.w,
          color: color,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          '$amountType - $amount',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
