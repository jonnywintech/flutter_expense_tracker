import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();

  // clean up memeory when modal is closed
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Title',
              icon: Icon(Icons.title),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                },
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
