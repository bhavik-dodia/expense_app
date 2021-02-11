import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/transaction_data.dart';
import '../widgets/chart.dart';
import '../widgets/transaction_list.dart';
import 'add_transaction.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController _fabController;
  Animation<double> _fabFadeAnimation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    getApplicationDocumentsDirectory().then(
      (Directory directory) =>
          File('${directory.path}/transactions.json').readAsString().then(
                (value) => Provider.of<TransactionData>(context, listen: false)
                    .loadTransactions(value),
              ),
    );

    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fabFadeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _fabController, curve: Curves.easeInBack),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused)
      Provider.of<TransactionData>(context, listen: false).saveTransactions();
  }

  @override
  void dispose() {
    _fabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme.accentColor,
      body: Padding(
        padding: EdgeInsets.only(top: mediaQuery.padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Expense manager',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: theme.canvasColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: mediaQuery.orientation == Orientation.portrait
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Chart(
                          height: mediaQuery.size.height * 0.2,
                          recentTransactions:
                              Provider.of<TransactionData>(context)
                                  .recentTransactions,
                        ),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                              color: theme.canvasColor,
                            ),
                            child: TransactionList(
                              onReverse: () =>
                                  _fabController.forward().whenComplete(
                                        () => Future.delayed(
                                          const Duration(seconds: 2),
                                          () => _fabController.reverse(),
                                        ),
                                      ),
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
                          child: Chart(
                            height: mediaQuery.size.height * 0.5,
                            recentTransactions:
                                Provider.of<TransactionData>(context)
                                    .recentTransactions,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                              ),
                              color: theme.canvasColor,
                            ),
                            child: TransactionList(
                              onReverse: () => _fabController.forward().whenComplete(
                                        () => Future.delayed(
                                          const Duration(seconds: 2),
                                          () => _fabController.reverse(),
                                        ),
                                      ),
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
      floatingActionButton: ScaleTransition(
        scale: _fabFadeAnimation,
        child: FloatingActionButton(
          tooltip: 'Add New Transaction',
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => AddTransaction(),
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            isScrollControlled: true,
          ),
          backgroundColor: theme.accentColor,
          splashColor: theme.accentColor,
          child: Icon(
            Icons.add_rounded,
            color: theme.canvasColor,
            size: 35.0,
          ),
        ),
      ),
    );
  }
}
