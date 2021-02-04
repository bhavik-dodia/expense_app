import 'package:expense_app/models/transaction_data.dart';
import 'package:expense_app/screens/add_transaction.dart';
import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _fabController;
  Animation<double> _fabFadeAnimation;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fabFadeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _fabController, curve: Curves.easeInBack),
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense manager',
          style: TextStyle(
            fontSize: 20.0,
            color: Theme.of(context).canvasColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                  children: [
                    Chart(
                      recentTransactions:
                          Provider.of<TransactionData>(context, listen: false)
                              .recentTransactions,
                    ),
                    Expanded(
                      child: TransactionList(
                        onBottom: () => _fabController.forward(),
                        onTop: () => _fabController.reverse(),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Chart(
                        recentTransactions:
                            Provider.of<TransactionData>(context, listen: false)
                                .recentTransactions,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TransactionList(
                        onBottom: () => _fabController.forward(),
                        onTop: () => _fabController.reverse(),
                      ),
                    ),
                  ],
                ),
          Positioned(
            bottom: 18.0,
            right: 18.0,
            child: ScaleTransition(
              scale: _fabFadeAnimation,
              child: FloatingActionButton(
                tooltip: 'Add New Transaction',
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => AddTransaction(),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  isScrollControlled: true,
                ),
                backgroundColor: Theme.of(context).accentColor,
                splashColor: Theme.of(context).accentColor,
                child: Icon(
                  Icons.add_rounded,
                  color: Theme.of(context).canvasColor,
                  size: 35.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
