import 'dart:ffi';
import 'package:expenses/data.dart';
import 'package:expenses/model/category.dart';
import 'package:expenses/model/transaction.dart';
import 'package:expenses/screens/addExpense.dart';
import 'package:expenses/screens/allTransactions.dart';
import 'package:expenses/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'setting.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String budget = '0.0';
  String limit = '0.0';
  double spent = 0.0;
  double balance = 0.0;

  @override
  void initState() {
    initVariable().whenComplete(() {
      spentCal();
    });
    super.initState();
  }

  spentCal() {
    for (var element in transactions) {
      if (element.dateTime.month == DateTime.now().month &&
          element.dateTime.year == DateTime.now().year) {
        spent += element.amount;
      }
    }
  }

  initVariable() async {
    var pref = await SharedPreferences.getInstance();
    await setExpense();
    setState(() {
      budget = pref.getString('budget') ?? '0.0';
      limit = pref.getString('limit') ?? '0.0';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    initVariable();
    return Scaffold(
      backgroundColor: Color(0xff010001),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      'EXPENSE TRACKER',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    IconButton(
                        onPressed: () async {
                          final value = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings()));
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.settings,
                          size: 35,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.23,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 45, 181, 156).withOpacity(1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          // for(int i=0; i<transactions.length;i++){
                          //   if(x){
                          //
                          //   }
                          // };
                          'BALANCE',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '₹${(double.parse(budget)) - spent}',
                          style: TextStyle(fontSize: 40),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'BUDGET',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              '₹$budget',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              'SPENT',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              '₹$spent',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'TRANSACTIONS',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                  ),
                  // TextButton(
                  //   child: const Text(
                  //     "VIEW ALL",
                  //     style: TextStyle(color: Color(0xffDADADA), fontSize: 15),
                  //   ),
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => AllTransactions()));
                  //   },
                  // )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    Category cate = category.where((element) {
                      return element.name == transactions[index].categoryName;
                    }).first;
                    // DateTime element = transactions[index].dateTime;
                    // if (transactions[index]
                    //     .dateTime
                    //     .isSameDate(DateTime.now())) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          //<-- SEE HERE
                          side: const BorderSide(width: 5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: const Color(0xff181919),
                        leading: cate.cateIcon,
                        title: Text(
                          transactions[index].name,
                          style: TextStyle(fontSize: 23),
                        ),
                        subtitle: Text(transactions[index].dateTime.timeAgo()),
                        trailing: Text("₹ ${transactions[index].amount}",
                            style: TextStyle(fontSize: 23)),
                      );
                    // } else {
                    //   return Container();
                    // }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM/yyyy').format(this);
    }
  }
}
