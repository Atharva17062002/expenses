import 'dart:ffi';

import 'package:expenses/screens/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:intl/intl.dart';

import '../data.dart';
import '../model/category.dart';
import '../model/transaction.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  double spent = 0.0;
  DateTime selectedDate = DateTime.now();

  // TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  // @override
  // void initState() {
  //   spentdayCal();
  //   super.initState();
  // }

  spentdayCal() {
    for (var element in transactions) {
      if (element.dateTime.isSameDate(selectedDate)) {
        spent += element.amount;
      }
    }
  }

  late String formattedDate;

  @override
  Widget build(BuildContext context) {
    spentdayCal();
    return Scaffold(
      backgroundColor: const Color(0xff010001),
      appBar: AppBar(
        backgroundColor: const Color(0xff010001),
        elevation: 0,
        title: const Text(
          'All Transactions',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff03EFC4).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 9),
                      child: IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          size: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      formattedDate = DateFormat.yMMMMd().format(selectedDate),
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                )),
          ),
          Positioned(
            top: 102,
            left: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff03EFC4).withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              height: MediaQuery.of(context).size.height * 0.11,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Text(
                      'You have spent ₹${spent} on this day.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 10,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.55,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  Category cate = category.where((element) {
                    return element.name == transactions[index].categoryName;
                  }).first;
                  DateTime element = transactions[index].dateTime;
                  List<Transaction> list = transactions;
                  //print('${transactions[index].dateTime} - ${selectedDate}');
                  if (transactions[index].dateTime.isSameDate(selectedDate)) {
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
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
