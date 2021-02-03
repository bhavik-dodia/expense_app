import 'package:expense_app/modal/transaction.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 70.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense manager',
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context, txIndex) {
                var tx = transactions[txIndex];
                return Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: Text(tx.amount.toString()),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.redAccent,
                      ),
                      iconSize: 30.0,
                      onPressed: () {},
                    ),
                    title: Text(
                      tx.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Text(
                      tx.date.toString(),
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
