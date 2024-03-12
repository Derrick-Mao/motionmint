import 'package:motionmint/bar%20graph/bar_graph.dart';
import 'package:motionmint/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:motionmint/datetime/datetime_helper.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({
    super.key,
    required this.startOfWeek
  });

  double calcMax(
    ExpenseData value, 
    String monday, 
    String tuesday, 
    String wednesday, 
    String thursday, 
    String friday, 
    String saturday, 
    String sunday,) 
    {
      List<double> values = [
        value.calcDailyExpenseSum()[monday] ?? 0,
        value.calcDailyExpenseSum()[tuesday] ?? 0,
        value.calcDailyExpenseSum()[wednesday] ?? 0,
        value.calcDailyExpenseSum()[thursday] ?? 0,
        value.calcDailyExpenseSum()[friday] ?? 0,
        value.calcDailyExpenseSum()[saturday] ?? 0,
        value.calcDailyExpenseSum()[sunday] ?? 0,
      ];

      values.sort();
      double max = 0;
      
      if (values.last < 100) {
        max = 100;
      }

      else {
        max = values.last * 1.1;
      }

    return max;
    }

  @override
  Widget build(BuildContext context) {
    String monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: calcMax(value, monday, tuesday, wednesday, thursday, friday, saturday, sunday),
          monAmount: value.calcDailyExpenseSum()[monday] ?? 0,
          tueAmount: value.calcDailyExpenseSum()[tuesday] ?? 0,
          wedAmount: value.calcDailyExpenseSum()[wednesday] ?? 0,
          thuAmount: value.calcDailyExpenseSum()[thursday] ?? 0,
          friAmount: value.calcDailyExpenseSum()[friday] ?? 0,
          satAmount: value.calcDailyExpenseSum()[saturday] ?? 0,
          sunAmount: value.calcDailyExpenseSum()[sunday] ?? 0,
        ),
      ),
    );
  }
}