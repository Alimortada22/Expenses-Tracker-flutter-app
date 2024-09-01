import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
const uuid = Uuid();
final formatteddate= DateFormat().add_yMd();

enum Categores { food, travel, work, lesiure }
const iconcategory = {
  Categores.food : Icons.lunch_dining_rounded,
  Categores.travel:Icons.flight_takeoff,
  Categores.lesiure:Icons.movie,
  Categores.work:Icons.work
};

class Expenses {
  final String? id;
  final String? title;
  final double amount;
  final DateTime date;
  final Categores category;
  String get newdate{
    return formatteddate.format(date);
  }
  Expenses(
      {required this.category,
      required this.title,
      required this.amount,
      required this.date})
      : id = uuid.v4();
}


class Expansebucet{
  final Categores category;
  final List<Expenses> expenselist;

  Expansebucet({required this.category, required this.expenselist});
  Expansebucet.forcategory(List<Expenses>allexpense,this.category):
  expenselist=allexpense.where((element) =>  element.category==category).toList();
  get totalexpenses{
    double sum=0;
    for (var expense in expenselist) {
      sum=sum+expense.amount;
      
    }
return sum;
  }
}