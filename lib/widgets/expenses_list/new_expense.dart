import 'dart:developer';

import 'package:expenses_app/models/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense(this.newexpense, this.updblance, {super.key});
  final void Function(Expenses newexpense) newexpense;
  final void Function(double newblance) updblance;
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController inputtitle = TextEditingController();
  final TextEditingController inputamount = TextEditingController();
  DateTime? selctedate;
  DateFormat formatter = DateFormat.yMd();
  Categores? selectedcategory;
  @override
  void dispose() {
    super.dispose();

    inputtitle.dispose();
    inputamount.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: ((ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboard + 25),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          maxLength: 50,
                          controller: inputtitle,
                          decoration: const InputDecoration(
                            label: Text("Title"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: inputamount,
                          decoration: const InputDecoration(
                              label: Text("Amount"), suffixText: "\$"),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    maxLength: 50,
                    controller: inputtitle,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          hint: const Text("Category"),
                          value: selectedcategory,
                          items: Categores.values
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.name.toUpperCase())))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedcategory = val;
                            });
                          }),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              selctedate == null
                                  ? "no selected date"
                                  : formatter.format(selctedate!),
                              style: const TextStyle(color: Colors.black),
                            ),
                            IconButton(
                                onPressed: () async {
                                  final now = DateTime.now();
                                  final lastdate = DateTime(
                                      now.year - 1, now.month, now.day);

                                  final pickdate = await showDatePicker(
                                      context: context,
                                      firstDate: lastdate,
                                      lastDate: now);
                                  setState(() {
                                    selctedate = pickdate;
                                  });
                                },
                                icon: const Icon(Icons.calendar_month)),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: inputamount,
                        decoration: const InputDecoration(
                            label: Text("Amount"), suffixText: "\$"),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            selctedate == null
                                ? "no selected date"
                                : formatter.format(selctedate!),
                            style: const TextStyle(color: Colors.black),
                          ),
                          IconButton(
                              onPressed: () async {
                                final now = DateTime.now();
                                final lastdate =
                                    DateTime(now.year - 1, now.month, now.day);

                                final pickdate = await showDatePicker(
                                    context: context,
                                    firstDate: lastdate,
                                    lastDate: now);
                                setState(() {
                                  selctedate = pickdate;
                                });
                              },
                              icon: const Icon(Icons.calendar_month)),
                        ],
                      ),
                    ),
                  ]),
                const SizedBox(
                  height: 15,
                ),
                if (width >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            final enterdamount =
                                double.tryParse(inputamount.text);
                            final bool invalidamount =
                                enterdamount == null || enterdamount <= 0;
                            if (inputtitle.text.trim().isEmpty ||
                                invalidamount ||
                                selctedate == null ||
                                selectedcategory == null) {
                              log("error");
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: const Text("error"),
                                        content: const Text(
                                            "please make sure you enterd vaild values"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(ctx);
                                              },
                                              child: const Text("okay"))
                                        ],
                                      ));
                            } else {
                              widget.newexpense(Expenses(
                                  category: selectedcategory!,
                                  title: inputtitle.text,
                                  amount: enterdamount,
                                  date: selctedate!));
                              Navigator.pop(context);
                              widget.updblance(enterdamount);
                            }
                          },
                          child: const Text("save Expanse")),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          hint: const Text("Category"),
                          value: selectedcategory,
                          items: Categores.values
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.name.toUpperCase())))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedcategory = val;
                            });
                          }),
                      const SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            final enterdamount =
                                double.tryParse(inputamount.text);
                            final bool invalidamount =
                                enterdamount == null || enterdamount <= 0;
                            if (inputtitle.text.trim().isEmpty ||
                                invalidamount ||
                                selctedate == null ||
                                selectedcategory == null) {
                              log("error");
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: const Text("error"),
                                        content: const Text(
                                            "please make sure you enterd vaild values"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(ctx);
                                              },
                                              child: const Text("okay"))
                                        ],
                                      ));
                            } else {
                              widget.newexpense(Expenses(
                                  category: selectedcategory!,
                                  title: inputtitle.text,
                                  amount: enterdamount,
                                  date: selctedate!));
                              Navigator.pop(context);
                              widget.updblance(enterdamount);
                            }
                          },
                          child: const Text("save Expanse")),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
