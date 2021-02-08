import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:expense_app/models/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class TransactionData extends ChangeNotifier {
  List<Transaction> _transactions = [];

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

  void loadTransactions(String res) {
    var txObj = jsonDecode(res) as List;
    _transactions = txObj.map((i) => Transaction.fromJson(i)).toList();
    notifyListeners();
  }

  void saveTransactions() => getApplicationDocumentsDirectory().then(
      (Directory directory) => File('${directory.path}/transactions.json')
              .writeAsStringSync(jsonEncode(
            _transactions,
          )));

  void addTransaction(
    int txId,
    String txTitle,
    double txAmount,
    DateTime txDate,
  ) {
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
