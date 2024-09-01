import 'package:expenses_app/models/expenses.dart';
import 'package:expenses_app/widgets/expenses_list/chart_bar.dart';

import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart(this.expanses, {super.key});
  final List<Expenses> expanses;
  List<Expansebucet> get expensesbucket {
    return [
      Expansebucet.forcategory(expanses, Categores.food),
      Expansebucet.forcategory(expanses, Categores.lesiure),
      Expansebucet.forcategory(expanses, Categores.travel),
      Expansebucet.forcategory(expanses, Categores.work),
    ];
  }

  double get maxtotalexpense {
    double max = 0.0;
    for (var element in expensesbucket) {
      if (element.totalexpenses > max) {
        max = element.totalexpenses;
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      height: 175,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.onPrimary
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final ele in expensesbucket)
                  ChartBar(
                    fill: ele.totalexpenses == 0
                        ? 0
                        : ele.totalexpenses / maxtotalexpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Row(
            children: expensesbucket
                .map((e) => Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(iconcategory[e.category]),
                    )))
                .toList(),
          )
        ],
      ),
    );
  }
}
