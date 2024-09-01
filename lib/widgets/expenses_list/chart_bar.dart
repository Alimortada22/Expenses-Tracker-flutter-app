import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({this.fill, super.key});
  final double? fill;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FractionallySizedBox(
        heightFactor: fill,
        child:  DecoratedBox(
          
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)))),
      ),
    ));
  }
}
