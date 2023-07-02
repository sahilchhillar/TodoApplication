package com.todo.todo.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.todo.todo.model.Entity.Todo;
import com.todo.todo.model.POJO.TodoPojo;

@Service
public interface TodoService {
    ResponseEntity<HttpStatus> saveTask(TodoPojo todoPojo) throws Exception;
    List<Todo> getPendingTasks() throws Exception;
    List<Todo> getCompletedTasks() throws Exception;
    ResponseEntity<HttpStatus> updateTask(String id, TodoPojo todoPojo) throws Exception;
    ResponseEntity<HttpStatus> deleteTask(String id) throws Exception;
    ResponseEntity<HttpStatus> updatePending(String id) throws Exception;
}
