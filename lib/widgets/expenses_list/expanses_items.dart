import 'package:expenses_app/models/expenses.dart';
import 'package:flutter/material.dart';

class Expansesitems extends StatelessWidget {
  const Expansesitems(this.expense, {super.key});
  final Expenses expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "${expense.title}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text("${expense.amount}\$"),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.access_time),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(expense.newdate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
