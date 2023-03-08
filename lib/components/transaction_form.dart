import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double)? onSubmit;

  TransactionForm({this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0;

    if (title.isEmpty || value <= 0) return;

    widget.onSubmit!(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                  Text('No date selected!'),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Colors.transparent)),
                    onPressed: () {},
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
    );
  }
}
