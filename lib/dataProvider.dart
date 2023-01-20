import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier{
  double budget = 0.0;
  double limit = 0.0;

  setbudget(double b){
    budget = b;
    notifyListeners();
  }

  setlimit(double l){
    limit = l;
    notifyListeners();
  }
}
