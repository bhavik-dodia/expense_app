import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/screens/add_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _fabController;
  Animation<double> _fabFadeAnimation;

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
  void initState() {
    super.initState();
    _fabController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _fabFadeAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _fabController, curve: Curves.easeInBack));
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
        title: const Text(
          'Expense manager',
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: TransactionList(
                  onBottom: () => _fabController.forward(),
                  onTop: () => _fabController.reverse(),
                ),
              ),
            ],
          ),
          Align(
            heightFactor:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 11.7
                    : 4.35,
            alignment: Alignment.bottomCenter,
            child: ScaleTransition(
              scale: _fabFadeAnimation,
              child: FloatingActionButton(
                // shape: SquircleBorder(),
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
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
