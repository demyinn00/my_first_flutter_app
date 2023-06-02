import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/main.dart';

class ObscuredTextFieldSample extends StatelessWidget {
  const ObscuredTextFieldSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
        ),
      ),
    );
  }
}

class MyNewToDoPage extends StatefulWidget {
  const MyNewToDoPage({super.key, required this.title, this.task});
  final String title;
  final Task? task;

  @override
  State<MyNewToDoPage> createState() => _MyNewToDoPageState();
}

class _MyNewToDoPageState extends State<MyNewToDoPage> {
  late final Task _task;
  bool _isDone = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _task = widget.task!;
    } else {
      _task = Task(isDone: false, title: '', notes: '');
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _cancelCreation() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage(title: "To-do list")),
    );
  }

  void _confirmCreation() {
    _task.isDone = _isDone;
    _task.title = _titleController.text;
    _task.notes = _notesController.text;

    Navigator.pop(context, _task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New To-do Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: _isDone,
                  onChanged: (value) {
                    setState(() {
                      _isDone = value!;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TextField(
                controller: _notesController,
                decoration: const InputDecoration(hintText: 'Notes'),
                maxLines: null, // Allows unlimited lines for notes
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _cancelCreation,
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _confirmCreation,
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
