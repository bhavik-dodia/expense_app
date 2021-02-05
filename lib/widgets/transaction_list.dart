import 'package:expense_app/models/transaction_data.dart';
import 'package:expense_app/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatefulWidget {
  final Function onReverse;
  final Function onForward;

  const TransactionList({Key key, this.onReverse, this.onForward})
      : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) widget.onForward();
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) widget.onReverse();
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
              ? Center(
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Image.asset(
                        'images/no_data.png',
                        height: 150.0,
                        width: 150.0,
                      ),
                      const SizedBox(height: 15.0),
                      const Text(
                        'You\'re all caught up!\nAdd a new transaction',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8.0),
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  shrinkWrap: true,
                  itemCount: transactionData.transactionCount,
                  itemBuilder: (context, txIndex) => Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: TransactionTile(
                      tx: transactionData.transactions[txIndex],
                    ),
                  ),
                ),
    );
  }
}
