import 'dart:io';

import 'package:expense_app/models/transaction_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String _newTxTitle;
  String _newAmount;
  DateTime _selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime date = Platform.isAndroid
        ? await showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime(DateTime.now().year + 5),
            fieldLabelText: 'Transaction happened on',
          )
        : await showCupertinoModalPopup(
            context: context,
            builder: (context) => Container(
              height: 260,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: _selectedDate,
                      onDateTimeChanged: (val) =>
                          setState(() => _selectedDate = val),
                    ),
                  ),
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 15.0,
        right: 15.0,
      ),
      children: [
        const Icon(
          Icons.horizontal_rule_rounded,
          size: 40.0,
          color: Colors.grey,
        ),
        Text(
          'New Transaction',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: theme.accentColor,
          ),
        ),
        TextField(
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            filled: false,
            hintText: 'Enter title',
            hintStyle: const TextStyle(fontSize: 18.0),
          ),
          onChanged: (value) {
            if (value != null) setState(() => _newTxTitle = value);
          },
          cursorColor: theme.accentColor,
          textAlign: TextAlign.center,
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(fontSize: 18.0),
        ),
        TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            filled: false,
            hintText: 'Enter amount',
            hintStyle: const TextStyle(fontSize: 18.0),
          ),
          cursorColor: theme.accentColor,
          onChanged: (value) {
            if (value != null) setState(() => _newAmount = value);
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Card(
                elevation: 0.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: theme.accentColor.withOpacity(0.3),
                child: IconButton(
                  tooltip: 'Select date',
                  icon: Icon(
                    Icons.event_rounded,
                    color: theme.accentColor,
                  ),
                  highlightColor: theme.accentColor.withOpacity(0.4),
                  splashColor: theme.accentColor.withOpacity(0.5),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
            Expanded(
              flex: MediaQuery.of(context).orientation == Orientation.landscape
                  ? 10
                  : 3,
              child: const SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: MaterialButton(
                onPressed: () {
                  if (_newTxTitle != null) {
                    Provider.of<TransactionData>(context, listen: false)
                        .addTransaction(
                            Provider.of<TransactionData>(context, listen: false)
                                    .transactionCount +
                                1,
                            _newTxTitle,
                            double.parse(_newAmount),
                            _selectedDate);
                    Toast.show(
                      'Transaction added...',
                      context,
                      gravity: Toast.BOTTOM,
                    );
                    Navigator.of(context).pop();
                  } else {
                    Toast.show(
                      'Please give a title',
                      context,
                      gravity: Toast.TOP,
                    );
                  }
                },
                elevation: 0.0,
                color: theme.accentColor.withOpacity(0.3),
                textColor: theme.accentColor,
                highlightColor: theme.accentColor.withOpacity(0.4),
                splashColor: theme.accentColor.withOpacity(0.5),
                highlightElevation: 0.0,
                height: 48.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
