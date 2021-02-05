import 'dart:math';

import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/models/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key key,
    @required this.tx,
  }) : super(key: key);

  final Transaction tx;

  final List colors = const [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.deepPurpleAccent,
    Colors.deepOrangeAccent,
    Colors.pinkAccent,
    Colors.indigoAccent,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    final color = colors[Random().nextInt(colors.length)];
    return ListTile(
      leading: Container(
        height: 55.0,
        width: 55.0,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          color: color.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: RichText(
            text: TextSpan(
              text: '₹' + tx.amount.toStringAsFixed(1),
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete_forever_rounded,
          color: Colors.redAccent,
        ),
        iconSize: 30.0,
        onPressed: () => Provider.of<TransactionData>(context, listen: false)
            .deleteTransaction(tx),
      ),
      title: Text(
        tx.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      subtitle: Text(
        DateFormat('EEE, dd MMM yyyy').format(tx.date),
        style: const TextStyle(fontSize: 12.0),
      ),
    );
  }
}
