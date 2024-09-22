import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskController = TextEditingController();

  Future<void> _saveTask() async {
    if (_taskController.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> tasks = prefs.getStringList('tasks') ?? [];
      tasks.add(_taskController.text);
      await prefs.setStringList('tasks', tasks);
      Navigator.pop(context, true);  // Mengirim nilai true sebagai tanda sukses
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Tugas'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Nama Tugas',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text('Simpan Tugas'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
