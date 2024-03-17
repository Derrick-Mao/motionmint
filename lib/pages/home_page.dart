import 'package:flutter/material.dart';
import 'package:motionmint/components/expense_summary.dart';
import 'package:motionmint/components/expense_tile.dart';
import 'package:motionmint/data/expense_data.dart';
import 'package:motionmint/models/expense_item.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseDollarController = TextEditingController();
  final newExpenseCentController = TextEditingController();

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(
                hintText: "Expense name",
              ),
            ),
            Row(
              children: [
                Expanded(
                  // expense dollar
                  child: TextField(
                    controller: newExpenseDollarController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Dollars",
                    ),
                  ),
                ),
                Expanded(
                  // expense cent
                  child: TextField(
                    controller: newExpenseCentController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Cents",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),

          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void save() {
    // only save expense if all input fields are filled
    if (newExpenseCentController.text.isNotEmpty &&
        newExpenseDollarController.text.isNotEmpty &&
        newExpenseCentController.text.isNotEmpty) {
      // combine dollar and cents    
      String amount = '${newExpenseDollarController.text}.${newExpenseCentController.text}';

      // create new expense item
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: amount,
        dateTime: DateTime.now(),
      );

      // add the new expense item
      Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

      Navigator.pop(context);
      clear();
    }
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).removeExpense(expense);
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseDollarController.clear();
    newExpenseCentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          tooltip: 'Add new expense',
          child: const Icon(Icons.add),
        ),

        
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListView(children: [
            // weekly expense
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),

            // expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                dateTime: value.getAllExpenseList()[index].dateTime,
                amount: value.getAllExpenseList()[index].amount,
                deleteTapped: (p0) => deleteExpense(value.getAllExpenseList()[index]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}