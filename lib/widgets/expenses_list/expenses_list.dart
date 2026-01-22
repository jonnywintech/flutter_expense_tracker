import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;

  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (DismissDirection direction) {
          if (direction == DismissDirection.endToStart ||
              direction == DismissDirection.startToEnd) {
            onRemoveExpense(expenses[index]);
          }
        },
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
