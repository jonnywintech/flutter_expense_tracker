import 'package:flutter/material.dart';
import 'package:expenses_tracker/widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        primaryColor: Color(Colors.blue.shade600.value),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue.shade600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue.shade600,
          ),
        ),
        scaffoldBackgroundColor: Colors.blue.shade100,
      ),
      home: Expenses(),
    ),
  );
}
