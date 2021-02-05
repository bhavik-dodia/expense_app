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
        Text('₹ ' + spendingAmount.toStringAsFixed(0)),
        const SizedBox(height: 2),
        Card(
          elevation: 8.0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 60.0,
            width: 12.0,
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.redAccent,
                  Colors.amberAccent,
                  Colors.greenAccent,
                ],
                stops: [0, 0.5, 1],
              ),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 1 - spendingPctOfTotal,
              child: Container(
                color: Theme.of(context).canvasColor,
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
