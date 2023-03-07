import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this.transactions);

  List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((tr) {
        return Card(
            child: Row(
          children: [
            Container(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Color.fromARGB(110, 175, 40, 199),
                  width: 2,
                )),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  '${tr.value.toStringAsFixed(2)} €',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    tr.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('d MMM y').format(tr.date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ])
              ],
            )
          ],
        ));
      }).toList(),
    );
  }
}
