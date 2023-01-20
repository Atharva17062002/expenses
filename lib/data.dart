import 'package:expenses/model/category.dart';
import 'package:expenses/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/dictionaries/en.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

List<Transaction> transactions = [
  Transaction(
      name: 'KFC',
      dateTime: DateTime(2023, 01, 18),
      amount: 400,
      categoryName: 'Food'),
  Transaction(
      name: 'KFC',
      dateTime: DateTime(1997, 12, 07),
      amount: 400,
      categoryName: 'Entertainment'),
  Transaction(
      name: 'KFC',
      dateTime: DateTime(2023, 01, 18),
      amount: 400,
      categoryName: 'Fuel'),
  Transaction(
      name: 'KFC',
      dateTime: DateTime.now(),
      amount: 400,
      categoryName: 'Housing'),
];

// List<Transaction> trans = [];

List<Category> category = [
  Category(
    name: 'Category',
    cateIcon: CircleAvatar(
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.category,
      ),
    ),
  ),
  Category(
    name: 'Food',
    cateIcon: CircleAvatar(
      backgroundColor: Color(0xffffca5e),
      child: Icon(
        Icons.food_bank,
      ),
    ),
  ),
  Category(
    name: 'Entertainment',
    cateIcon: CircleAvatar(
      backgroundColor: Color(0xffb376e1),
      child: Icon(
        Entypo.ticket,
        color: Colors.black,
      ),
    ),
  ),
  Category(
    name: 'Fuel',
    cateIcon: CircleAvatar(
      backgroundColor: Color(0xffEA4243),
      child: Icon(
        FontAwesome5Solid.gas_pump,
        color: Colors.black,
      ),
    ),
  ),
  Category(
    name: 'Housing',
    cateIcon: CircleAvatar(
      backgroundColor: Color(0xff2891F4),
      child: Icon(
        Icons.house,
        color: Colors.black,
      ),
    ),
  ),
  Category(
    name: 'Investment',
    cateIcon: CircleAvatar(
      backgroundColor: Colors.greenAccent,
      child: Icon(
      Icons.money,
      color: Colors.black,
      ),
    ),
  ),
  Category(
    name: 'Shopping',
    cateIcon: CircleAvatar(
      backgroundColor: Colors.blue[900],
      child: Icon(
        Icons.shopping_bag,
        color: Colors.black,
      ),
    ),
  )
];
