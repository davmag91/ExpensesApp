// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import './models/transaction.dart';
import 'components/chart.dart';
import 'components/transaction_form.dart';
import 'models/transaction.dart';
import 'components/transaction_list.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          )),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      date: DateTime.now(),
      id: Random().nextDouble().toString(),
      value: 10,
      title: 'Socks',
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 3)),
      id: Random().nextDouble().toString(),
      value: 5,
      title: 'Teddy Bear',
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 2)),
      id: Random().nextDouble().toString(),
      value: 20,
      title: 'Shirt',
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 4)),
      id: Random().nextDouble().toString(),
      value: 5,
      title: 'Jeans',
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 5)),
      id: Random().nextDouble().toString(),
      value: 30,
      title: 'Random Groceries',
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 2)),
      id: Random().nextDouble().toString(),
      value: 2,
      title: 'Juice',
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 1)),
      id: Random().nextDouble().toString(),
      value: 15,
      title: 'Book',
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 4)),
      id: Random().nextDouble().toString(),
      value: 5,
      title: 'Book 2',
    ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where(
      (element) {
        return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      },
    ).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() => _transactions.add(newTransaction));

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: () => fn,
            child: Icon(icon),
          )
        : IconButton(
            onPressed: () => fn,
            icon: Icon(icon),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.news : Icons.list;
    final chartList = Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = <Widget>[
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () {
          _openTransactionFormModal(context);
        },
      ),
      if (isLandscape)
        _getIconButton(
          _showChart ? iconList : chartList,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
    ];

    final appBar;
    if (Platform.isIOS) {
      appBar = CupertinoNavigationBar(
        middle: Text('Personal Expenses'),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: actions),
      );
    } else {
      appBar = AppBar(
          title: Text(
            'Personal Expenses',
            style: TextStyle(
              fontSize: 20 * mediaQuery.textScaleFactor,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: actions);
    }

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('Exibir gráfico'),
            //       Switch.adaptive(
            //         activeColor: Theme.of(context).accentColor,
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() => _showChart = value);
            //         },
            //       ),
            //     ],
            //   ),
            if (_showChart || !isLandscape)
              Container(
                child: Chart(_recentTransactions),
                height: availableHeight * (isLandscape ? 0.8 : 0.3),
              ),
            if (!_showChart || !isLandscape)
              Container(
                  height: availableHeight * (isLandscape ? 1 : 0.7),
                  child: TransactionList(_transactions, _deleteTransaction)),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyPage,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      _openTransactionFormModal(context);
                    },
                    child: Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
