// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  String name;
  DateTime dateTime;
  double amount;
  String categoryName;
  Transaction({
    required this.name,
    required this.dateTime,
    required this.amount,
    required this.categoryName,
  });

  Transaction copyWith({
    String? name,
    DateTime? dateTime,
    double? amount,
    String? categoryName,
  }) {
    return Transaction(
      name: name ?? this.name,
      dateTime: dateTime ?? this.dateTime,
      amount: amount ?? this.amount,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'amount': amount,
      'categoryName': categoryName,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      name: map['name'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      amount: map['amount'] as double,
      categoryName: map['categoryName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(name: $name, dateTime: $dateTime, amount: $amount, categoryName: $categoryName)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.dateTime == dateTime &&
      other.amount == amount &&
      other.categoryName == categoryName;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      dateTime.hashCode ^
      amount.hashCode ^
      categoryName.hashCode;
  }
}
