import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double)? onSubmit;

  TransactionForm({this.onSubmit});

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0;

    if (title.isEmpty || value <= 0) return;

    onSubmit!(title, value);
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
                labelText: 'Título',
              ),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: valueController,
              onSubmitted: (value) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (€)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text(
                    'Nova Transação',
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
