import 'package:flutter/material.dart';
import 'login_page.dart';
import 'new_todo_page.dart';

void main() {
  runApp(const MyApp());
}

const String newToDoTitle = "New To-do";
const String homeTitle = "To-do";
const String loginTitle = "Login or Sign up!";
const String toDoTitle = "To-do task";

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
      home: const MyLoginPage(title: loginTitle)//const MyHomePage(title: 'To-do List Home Page!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, this.newTask});

  final String title;
  final Task? newTask;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Task {
  bool isDone;
  String title;
  String notes;

  Task({required this.isDone, required this.title, required this.notes});
}

class _MyHomePageState extends State<MyHomePage> {
  bool _deleteMode = false;
  final List<Task> _tasks = [
    Task(isDone: false, title: 'Task 1', notes: 'notes11111 notesssss'),
    Task(isDone: false, title: 'Task 2', notes: 'notesssss 22222 notesssss'),
    Task(isDone: false, title: 'Task 3', notes: 'notes 333333 notesssss'),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.newTask != null) {
      _tasks.add(widget.newTask!);
    }
  }

  void _navigateToTaskDetail(BuildContext context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyNewToDoPage(title: task.title, task: task)),
    );
  }

  void _createNewToDo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyNewToDoPage(title: newToDoTitle)),
    ).then((newTask) {
      if (newTask != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: homeTitle, newTask: newTask as Task)),
        );
      }
    });
  }

  void _signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyLoginPage(title: loginTitle)),
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
                    title: Text(_tasks[index].title),
                    leading: Checkbox(
                      value: _tasks[index].isDone,
                      onChanged: (newValue) {
                        setState(() {
                          _tasks[index].isDone = newValue!;
                        });
                      },
                    ),
                    onTap: _deleteMode
                        ? () => _deleteTask(index)
                        : () => _navigateToTaskDetail(context, _tasks[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (_deleteMode) return Colors.red; // Use the color red when delete mode is active.
                          return Colors.white; // Use the default color when delete mode is inactive.
                        },
                      ),
                    ),
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
