import 'package:flutter/cupertino.dart';

class Transaction {
  final int id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });

  Map toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'date': date.toIso8601String(),
      };

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'],
        title: json['title'],
        amount: json['amount'],
        date:DateTime.tryParse(json['date']),
      );
}
