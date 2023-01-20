import 'dart:convert';

import 'package:expenses/data.dart';
import 'package:expenses/model/category.dart';
import 'package:expenses/model/transaction.dart';
import 'package:expenses/screens/dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  late SharedPreferences preferences;
  String dropdownvalue = 'Category';
  late String formattedDate;
  DateTime selectedDate = DateTime.now();

  void saveExpense() async {
    preferences = await SharedPreferences.getInstance();
    List items = transactions.map((e) => e.toJson()).toList();
    preferences.setString('Expense', jsonEncode(items));
  }

  // TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  final amountController = TextEditingController();
  final noteController = TextEditingController();
  // final datController = TextEditingController();
  final cateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff010001),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff010001),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       icon: const Icon(
        //         Icons.close,
        //         size: 40,
        //       ))
        // ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width / 3.5,
            top: 10,
            child: const Text(
              'Add Expense',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Positioned(
            top: 65,
            left: 78,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff181919),
                  borderRadius: BorderRadius.circular(10)),
              height: 60,
              width: 250,
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    '₹',
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(
                      width: 180,
                      child: TextFormField(
                        controller: amountController,
                        decoration: const InputDecoration(
                            hintText: '500',
                            hintStyle: TextStyle(fontSize: 35),
                            border: InputBorder.none),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 35),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                      )),
                ],
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: const Color(0xff181919),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(
                    Icons.note,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: TextFormField(
                      controller: noteController,
                      decoration: const InputDecoration(
                          hintText: 'Note',
                          hintStyle:
                              TextStyle(fontSize: 30, color: Colors.white),
                          border: InputBorder.none),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 35),
                      // keyboardType:
                      // const TextInputType.numberWithOptions(decimal: true),
                      // inputFormatters: <TextInputFormatter>[
                      //   FilteringTextInputFormatter.allow(
                      //       RegExp(r'^(\d+)?\.?\d{0,2}'))
                      // ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 20,
            right: 20,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  color: const Color(0xff181919),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_month,
                        size: 35,
                      ),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    formattedDate = DateFormat.yMMMMd().format(selectedDate),
                    style: TextStyle(fontSize: 28),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 350,
            left: 20,
            right: 20,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  color: const Color(0xff181919),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.list,
                    size: 40,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: DropDownCategory()),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).size.height * 0.02,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff03efc4).withOpacity(0.7)),
              child: TextButton(
                onPressed: () async {
                  transactions.add(
                    Transaction(
                        name: noteController.text,
                        dateTime: DateTime.now(),
                        amount: double.parse(amountController.text),
                        categoryName: dropdownvalue),
                  );
                  saveExpense();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(),
                    ),
                  );
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DropDownCategory extends StatefulWidget {
  const DropDownCategory({Key? key}) : super(key: key);

  @override
  State<DropDownCategory> createState() => _DropDownCategoryState();
}

class _DropDownCategoryState extends State<DropDownCategory> {
  String dropdownValue = 'Food';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: category
          .map((Category item) => DropdownMenuItem<String>(
              value: item.name, child: Text(item.name)))
          .toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      value: dropdownValue,
    );
  }
}

setExpense() async {
  transactions = [];
  SharedPreferences? preferences;
  preferences = await SharedPreferences.getInstance();
  String? stringExpense = preferences.getString('Expense');
  if (stringExpense != null) {
    List expenseList = jsonDecode(stringExpense);

    for (var expense in expenseList) {
      Transaction track = Transaction.fromJson(expense);
      transactions.add(track);
    }
  }
  return transactions;
}
