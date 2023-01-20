import 'package:expenses/dataProvider.dart';
import 'package:expenses/screens/addExpense.dart';
import 'package:expenses/screens/allTransactions.dart';
import 'package:expenses/screens/dash.dart';
import 'package:expenses/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return DataProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(

        ),
        home: Dashboard(),
      ),
    );
  }
}

