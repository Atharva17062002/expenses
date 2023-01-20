// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Category {
  String name;
  Widget cateIcon;
  Category({
    required this.name,
    required this.cateIcon,
  });

  Category copyWith({
    String? name,
    Widget? cateIcon,
  }) {
    return Category(
      name: name ?? this.name,
      cateIcon: cateIcon ?? this.cateIcon,
    );
  }

 
}
