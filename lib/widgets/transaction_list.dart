import 'package:expense_app/models/transaction_data.dart';
import 'package:expense_app/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatefulWidget {
  final Function onBottom;
  final Function onTop;

  const TransactionList({Key key, this.onBottom, this.onTop}) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
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
    return Consumer<TransactionData>(
      builder: (context, transactionData, child) =>
          transactionData.transactionCount == 0
              ? ListView(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Image.asset(
                        'images/no_data.png',
                        scale: 3.5,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      'You\'re all caught up!\nAdd a new transaction',
                      textAlign: TextAlign.center,
                    )
                  ],
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemCount: transactionData.transactionCount,
                  itemBuilder: (context, txIndex) => Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: TransactionTile(
                        tx: transactionData.transactions[txIndex]),
                  ),
                ),
    );
  }
}
