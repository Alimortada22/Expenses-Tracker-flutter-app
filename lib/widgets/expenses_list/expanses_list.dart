import 'package:expenses_app/main.dart';
import 'package:expenses_app/models/expenses.dart';
import 'package:expenses_app/widgets/expenses_list/expanses_items.dart';
import 'package:flutter/material.dart';

class Expenanseslistview extends StatelessWidget {
  const Expenanseslistview(
    this.removeexpense, {
    super.key,
    required this.expenseslist,
  });

  final List<Expenses> expenseslist;
  final void Function(Expenses expense) removeexpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenseslist.length,
        itemBuilder: (context, index) => Dismissible(
            background: Container(
              margin: Theme.of(context).cardTheme.margin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: colorsceame.error.withOpacity(0.7),
              ),
              child: const Padding(
                padding: EdgeInsets.all(25.0),
                child: Text(
                  "Delete",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            key: ValueKey(index),
            onDismissed: (direction) => removeexpense(expenseslist[index]),
            child: Expansesitems(expenseslist[index])));
  }
}
