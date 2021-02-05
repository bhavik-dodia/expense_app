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
    return Container(
      width: 40.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: '₹ ' + spendingAmount.toStringAsFixed(0),
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
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
      ),
    );
  }
}
