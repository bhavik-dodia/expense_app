import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final Function onBottom;
  final Function onTop;

  const TransactionList({Key key, this.onBottom, this.onTop}) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final List<Transaction> _transactions = [
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
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 70.00,
      date: DateTime.now(),
    ),
  ];

  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        widget.onBottom();
      }
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        widget.onTop();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8.0),
      // physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _transactions.length,
      itemBuilder: (context, txIndex) {
        var tx = _transactions[txIndex];
        return Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            leading: Text(tx.amount.toString()),
            trailing: IconButton(
              icon: Icon(
                Icons.delete_forever_rounded,
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
              DateFormat('EEE, MMM d - hh:mm a').format(tx.date),
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        );
      },
    );
  }
}
