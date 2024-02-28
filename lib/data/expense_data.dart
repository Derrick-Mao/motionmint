class ExpenseData {
  // list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
  }

  // remove expense
  void removeExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
  }

  // get weekday name
  String getWeekdayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  // get start of the week date (Monday)
  DateTime startOfWeekDate() {
    DateTime startOfWeek;

    DateTime today = DateTime.now();

    // go to last Monday from today
    for (int i = 0; i < 7; ++i) {
      if (getWeekdayName(today.subtract(duration(days: i))) == 'Monday') {
        startOfWeek = today.subtract(duration(days: i));
      }
    }

    return startOfWeek;
  }

  // expense graph by day
  Map<String, double> calcDailyExpenseSum() {
    Map<String, double> dailyExpenseSum = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(exepense.dateTime);

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