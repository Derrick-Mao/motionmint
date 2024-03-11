import 'package:flutter/material.dart';
import 'package:motionmint/models/expense_item.dart';
import 'package:motionmint/datetime/datetime_helper.dart';

class ExpenseData extends ChangeNotifier {
  // list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
  }

  // remove expense
  void removeExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
  }

  // get weekday name
  String getWeekdayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'monday';
      case 2:
        return 'tuesday';
      case 3:
        return 'wednesday';
      case 4:
        return 'thursday';
      case 5:
        return 'friday';
      case 6:
        return 'saturday';
      case 7:
        return 'sunday';
      default:
        return '';
    }
  }

  // get start of the week date (Monday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    // go to last Monday from today
    for (int i = 0; i < 7; ++i) {
      if (getWeekdayName(today.subtract(Duration(days: i))) == 'monday') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  // expense graph by day
  Map<String, double> calcDailyExpenseSum() {
    Map<String, double> dailyExpenseSum = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);

      //string to double
      double amount = double.parse(expense.amount);

      if (dailyExpenseSum.containsKey(date)) {
        double currentAmount = dailyExpenseSum[date]!;
        currentAmount += amount;
        dailyExpenseSum[date] = currentAmount;
      }

      // new date
      else {
        dailyExpenseSum.addAll({date: amount});
      }
    }

    return dailyExpenseSum;
  }
}