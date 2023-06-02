import 'package:flutter/material.dart';
import 'login_page.dart';
import 'new_todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyNewToDoPage(title: "New To-do")//const MyHomePage(title: 'To-do List Home Page!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _deleteMode = false;
  final List<String> _tasks = ['Task 1', 'Task 2', 'Task 3'];

  void _createNewToDo() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyNewToDoPage(title: "New To-do")),
    );
  }

  void _signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyLoginPage(title: "Sign out")),
    );
  }

  void _toggleDeleteMode() {
    setState(() {
      _deleteMode = !_deleteMode;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_tasks[index]),
                    onTap: _deleteMode ? () => _deleteTask(index) : null,
                  );
                },
              ),// empty container to take up all available space
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  ElevatedButton(
                    onPressed: _toggleDeleteMode,
                    child: const Icon(Icons.remove),
                  ),
                  ElevatedButton(
                    onPressed: _createNewToDo,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
