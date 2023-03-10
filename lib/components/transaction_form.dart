import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime)? onSubmit;

  TransactionForm({this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();
  DateTime? selectedDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0;

    if (title.isEmpty || value <= 0 || selectedDate == null) return;

    widget.onSubmit!(title, value, selectedDate as DateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(children: <Widget>[
              TextField(
                controller: titleController,
                onSubmitted: (value) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: valueController,
                onSubmitted: (value) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Value (€)',
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: EdgeInsetsDirectional.only(end: 10),
                          child: Text(
                            selectedDate == null
                                ? 'No date selected!'
                                : 'Selected date: ' +
                                    DateFormat('d MMM y')
                                        .format(selectedDate as DateTime)
                                        .toString(),
                          )),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.grey)),
                      onPressed: () => showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime.now())
                          .then((pickedDate) {
                        if (pickedDate != null)
                          setState(() => selectedDate = pickedDate);
                      }),
                      child: Text('Select date',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .backgroundColor,
                    ),
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text('New Transaction',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
