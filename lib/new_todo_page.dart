import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/main.dart';

class ObscuredTextFieldSample extends StatelessWidget {
  const ObscuredTextFieldSample({super.key});

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
  const MyNewToDoPage({super.key, required this.title});

  final String title;

  @override
  State<MyNewToDoPage> createState() => _MyNewToDoPageState();
}

class _MyNewToDoPageState extends State<MyNewToDoPage> {
  bool _isDone = false;
  String _title = '';
  String _notes = '';

  void navigateHome(BuildContext context, int isConfirmed) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage(title: "To-do list")),
    );
  }

  void _cancelCreation() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage(title: "To-do list")),
    );
  }

  void _confirmCreation() {
    // save
    _isDone;
    _title;
    _notes;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage(title: "To-do list")),
    );
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
                    onChanged: (value) {
                      _title = value;
                    },
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  _notes = value;
                },
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
