import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/chart-bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  final double height;

  const Chart({Key key, this.recentTransactions, this.height})
      : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues =>
      List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;
        recentTransactions.forEach((recentTx) {
          if (recentTx.date.day == weekDay.day &&
              recentTx.date.month == weekDay.month &&
              recentTx.date.year == weekDay.year) totalSum += recentTx.amount;
        });
        return {
          'day': DateFormat.E().format(weekDay),
          'amount': totalSum,
        };
      });

  double get totalSpending =>
      groupedTransactionValues.fold(0.0, (sum, item) => sum += item['amount']);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: height,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues
              .map(
                (data) => ChartBar(
                  label: data['day'],
                  spendingAmount: data['amount'],
                  spendingPctOfTotal: totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
