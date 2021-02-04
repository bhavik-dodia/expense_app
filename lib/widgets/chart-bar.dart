import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(
      {Key key, this.label, this.spendingAmount, this.spendingPctOfTotal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('\$${spendingAmount.toStringAsFixed(0)}'),
        const SizedBox(height: 2),
        Card(
          elevation: 5.0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 60.0,
            width: 10.0,
            child: FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: spendingPctOfTotal,
              child: Container(
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(label),
      ],
    );
  }
}
