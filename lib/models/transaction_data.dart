import 'dart:collection';

import 'package:expense_app/models/transaction.dart';
import 'package:flutter/foundation.dart';

class TransactionData extends ChangeNotifier {
  List<Transaction> _transactions = [
    Transaction(
      id: 0,
      title: 'New Shoes',
      amount: 70.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 1,
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView(_transactions);

  List<Transaction> get recentTransactions => _transactions
      .where(
        (tx) => tx.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        ),
      )
      .toList();

  int get transactionCount => _transactions.length;

  void addTransaction(
      int txId, String txTitle, double txAmount, DateTime txDate) {
    _transactions.add(
      Transaction(
        title: txTitle,
        amount: txAmount,
        date: txDate,
        id: txId,
      ),
    );
    notifyListeners();
  }

  void deleteTransaction(Transaction tx) {
    _transactions.remove(tx);
    notifyListeners();
  }
}
