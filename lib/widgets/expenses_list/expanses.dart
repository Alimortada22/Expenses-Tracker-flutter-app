
import 'package:expenses_app/widgets/expenses_list/chart.dart';
import "package:expenses_app/models/expenses.dart";
import 'package:expenses_app/widgets/expenses_list/expanses_list.dart';
import 'package:expenses_app/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';

class Expanses extends StatefulWidget {
  const Expanses({super.key});

  @override
  State<Expanses> createState() => _ExpansesState();
}

class _ExpansesState extends State<Expanses> {
  final inputbalance = TextEditingController();
  late double balance = 0.0;

  final List<Expenses> expenseslist = [];
  void addnewexpense(Expenses newexpense) {
    setState(() {
      expenseslist.add(newexpense);
    });
  }

  void removeexpense(Expenses newexpense) {
    setState(() {
      expenseslist.remove(newexpense);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Expense deleted"),
        action: SnackBarAction(
            label: "Undo", onPressed: () => addnewexpense(newexpense)),
      ));
    });
  }

  void newbalance(double newbalc) {
    setState(() {
      balance = balance - newbalc;
    });
  }

  void enterdbalance(double enterdbalance) {
    setState(() {
      balance = enterdbalance;
    });
  }

  @override
  void dispose() {
    super.dispose();
    inputbalance.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget maincontent = const Center(
      child: Text("No Expenses Found. Starting To Add Some",
          style: TextStyle(color: Colors.black45)),
    );
    if (expenseslist.isNotEmpty) {
      maincontent =
          Expenanseslistview(expenseslist: expenseslist, removeexpense);
    }

    return Scaffold(
       resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        title: const Text("ExpenseTracker"),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                    context: context,
                    builder: (ctx) => AddExpense(addnewexpense, newbalance));
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: const Text("balance"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  final double dinputbalance =
                                      double.parse(inputbalance.text);
                                  enterdbalance(dinputbalance);
                                  Navigator.pop(context);
                                },
                                child: const Text("okay"))
                          ],
                          content: TextField(
                            keyboardType: TextInputType.number,
                            controller: inputbalance,
                            decoration: const InputDecoration(
                                label: Text("balance"), suffixText: "\$"),
                          ),
                        ));
              },
              icon: const Icon(Icons.attach_money))
        ],
        centerTitle: true,
      ),
      body: Center(
        child: width < 600
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chart(expenseslist),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Card(
                          child: Center(
                              child: Text(
                        "$balance \$",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400),
                      )))),
                  Expanded(child: maincontent),
                ],
              )
            : SizedBox(
              width: double.infinity,
              child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Chart(expenseslist),
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Card(
                                child: Center(
                                    child: Text(
                              "$balance \$",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w400),
                            ))))
                      ],
                    )),
                    Expanded(child: maincontent),
                  ],
                ),
            ),
      ),
    );
  }
}
