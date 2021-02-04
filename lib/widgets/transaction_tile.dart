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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(tx.amount.toString()),
      trailing: IconButton(
        icon: Icon(
          Icons.delete_forever_rounded,
          color: Colors.redAccent,
        ),
        iconSize: 30.0,
        onPressed: () => Provider.of<TransactionData>(context, listen: false)
            .deleteTransaction(tx),
      ),
      title: Text(
        tx.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      subtitle: Text(
        DateFormat('EEE, MMM d - hh:mm a').format(tx.date),
        style: TextStyle(fontSize: 12.0),
      ),
    );
  }
}
