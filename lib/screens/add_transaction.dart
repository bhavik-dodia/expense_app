import 'package:expense_app/models/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String newTxTitle;
  String newAmount;
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      fieldLabelText: 'Transaction happened on',
    );
    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            color: Theme.of(context).accentColor,
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
            if (value != null) setState(() => newTxTitle = value);
          },
          cursorColor: Theme.of(context).accentColor,
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
          cursorColor: Theme.of(context).accentColor,
          onChanged: (value) {
            if (value != null) setState(() => newAmount = value);
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
                color: Theme.of(context).accentColor.withOpacity(0.3),
                child: IconButton(
                  tooltip: 'Select date',
                  icon: Icon(
                    Icons.event_rounded,
                    color: Theme.of(context).accentColor,
                  ),
                  highlightColor:
                      Theme.of(context).accentColor.withOpacity(0.4),
                  splashColor: Theme.of(context).accentColor.withOpacity(0.5),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: const SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: MaterialButton(
                onPressed: () {
                  if (newTxTitle != null) {
                    Provider.of<TransactionData>(context, listen: false)
                        .addTransaction(
                            Provider.of<TransactionData>(context, listen: false)
                                    .transactionCount +
                                1,
                            newTxTitle,
                            double.parse(newAmount),
                            selectedDate);
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
                color: Theme.of(context).accentColor.withOpacity(0.3),
                textColor: Theme.of(context).accentColor,
                highlightColor: Theme.of(context).accentColor.withOpacity(0.4),
                splashColor: Theme.of(context).accentColor.withOpacity(0.5),
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
