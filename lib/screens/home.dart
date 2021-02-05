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
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 45.0),
                Text(
                  'Expense manager',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).canvasColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5.0),
                Expanded(
                  child:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chart(
                                  recentTransactions:
                                      Provider.of<TransactionData>(context)
                                          .recentTransactions,
                                ),
                                Expanded(
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0),
                                      ),
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    child: TransactionList(
                                      onReverse: () => _fabController.forward(),
                                      onForward: () => _fabController.reverse(),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Chart(
                                    recentTransactions:
                                        Provider.of<TransactionData>(context)
                                            .recentTransactions,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        bottomLeft: Radius.circular(25.0),
                                      ),
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    child: TransactionList(
                                      onReverse: () => _fabController.forward(),
                                      onForward: () => _fabController.reverse(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                ),
              ],
            ),
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
