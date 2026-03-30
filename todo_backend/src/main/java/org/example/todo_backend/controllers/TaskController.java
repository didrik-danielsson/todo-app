package org.example.todo_backend.controllers;

import org.example.todo_backend.entities.Task;
import org.example.todo_backend.services.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/tasks")
@CrossOrigin(origins = "*")
public class TaskController {


    @Autowired
    private TaskService taskService;

    @PostMapping
    public Task createTask(@RequestBody Task task) {
        return taskService.addTask(task);
    }

    @DeleteMapping("/delete")
    public void deleteTask(@RequestParam Long id) {
        taskService.deleteTask(id);
    }

    @GetMapping
    public Iterable<Task> getAllTasks() {
        return taskService.getAllTasks();
    }

    @GetMapping("/name/{name}")
    public Task getTasksByName(@PathVariable String title) {
        return taskService.getTasksByTitle(title);
    }

    @PutMapping("/update")
    public void updateTask(@RequestBody Task task) {
        taskService.updateTask(task);
    }
}
