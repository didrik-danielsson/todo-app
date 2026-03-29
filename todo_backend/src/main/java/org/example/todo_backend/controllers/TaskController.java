package org.example.todo_backend.controllers;

import org.example.todo_backend.services.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class TaskController {


    @Autowired
    private TaskService taskService;

}
