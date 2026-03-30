import 'package:flutter/material.dart';
import '../models/Task.dart';
import '../services/task_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Taskservice _taskService = Taskservice();
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }



  Future<void> _loadTasks() async {
    try {
      final tasks = await _taskService.getAllTasks();
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      _showError("Kunde inte hämta uppgifter: $e");
    }
  }


  Future<void> _deleteTask(int id) async {
    try {
     await _taskService.deleteTask(id);
      await _loadTasks();
    } catch (e) {
      _showError("Kunde inte ta bort: $e");
    }
  }

  Future<void> addTask(Task newTask) async {
    try {
      await _taskService.createTask(newTask);
      await _loadTasks();
    } catch (e) {
      _showError('Kunde inte lägga till');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mina Uppgifter")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteTask(task.id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Dialog för att lägga till ny uppgift
  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Ny uppgift"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Titel")),
            TextField(controller: descController, decoration: const InputDecoration(labelText: "Beskrivning")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Avbryt")),
          ElevatedButton(
              onPressed: () async {
                final newTask = Task(title: titleController.text, description: descController.text);
                addTask(newTask);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Spara")
          ),
        ],
      ),
    );
  }
}