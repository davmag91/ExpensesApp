import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AdaptativeDatepicker extends StatelessWidget {
  AdaptativeDatepicker({selectedDate, onDateChanged});

  DateTime? selectedDate;
  Function(DateTime)? onDateChanged;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged as Function(DateTime),
            ),
          )
        : Container(
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
                    if (pickedDate != null) onDateChanged!(pickedDate);
                  }),
                  child: Text('Select date',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
          );
  }
}
