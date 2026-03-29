package org.example.todo_backend.controllers;

import org.example.todo_backend.entities.Task;
import org.example.todo_backend.services.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class TaskController {


    @Autowired
    private TaskService taskService;

    @PostMapping("/tasks")
    public Task createTask(@RequestBody Task task) {
        return taskService.addTask(task);
    }

    @DeleteMapping("/delete")
    public void deleteTask(@RequestParam String id) {
        taskService.deleteTask(id);
    }

    @GetMapping
    public Iterable<Task> getAllTasks() {
        return taskService.getAllTasks();
    }

    @GetMapping("/name/{name}")
    public Task getTasksByName(@PathVariable String name) {
        return taskService.getTasksByName(name);
    }

    @PutMapping("/update")
    public void updateTask(@RequestBody Task task) {
        taskService.updateTask(task);
    }
}
