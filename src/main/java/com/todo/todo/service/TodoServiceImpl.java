package com.todo.todo.service;

import java.util.List;
import java.util.Optional;
import java.time.LocalDate;
import java.time.ZoneId;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.todo.todo.model.Entity.Todo;
import com.todo.todo.model.POJO.TodoPojo;
import com.todo.todo.repository.TodoRepository;

@Service
public class TodoServiceImpl implements TodoService {
    @Autowired
    private TodoRepository todoRepository;

    @Override
    public ResponseEntity<HttpStatus> saveTask(TodoPojo todoPojo) throws Exception {
        try {
            Todo todo = new Todo(todoPojo.getTask(), todoPojo.isPending(), LocalDate.now(ZoneId.systemDefault()), LocalDate.now(ZoneId.systemDefault()));
            todoRepository.save(todo);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            System.out.println("Exception thrown: " + e.getMessage());
            throw new Exception(e);
        }
    }

    @Override
    public List<Todo> getPendingTasks() throws Exception {
        try {
            List<Todo> tasks = todoRepository.findByPending(true);
            System.out.println(tasks.size());
            return tasks;
        } catch (Exception e) {
            System.out.println("Exception thrown: " + e.getMessage());
            throw new Exception(e);
        }
    }

    @Override
    public List<Todo> getCompletedTasks() throws Exception {
        try {
            List<Todo> tasks = todoRepository.findByPending(false);
            return tasks;
        } catch (Exception e) {
            System.out.println("Exception thrown: " + e.getMessage());
            throw new Exception(e);
        }
    }

    @Override
    public ResponseEntity<HttpStatus> updateTask(String id, TodoPojo todoPojo) throws Exception {
        try {
            boolean foundTask = todoRepository.existsById(id);
            if(foundTask){
                Optional<Todo> todo = todoRepository.findById(id);
                Todo task = todo.get();
                task.setTask(todoPojo.getTask());
                todoRepository.save(task);
                return new ResponseEntity<HttpStatus>(HttpStatus.OK);
            }
            return new ResponseEntity<HttpStatus>(HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            System.out.println("Exception thrown: " + e.getMessage());
            throw new Exception(e);
        }
    }

    @Override
    public ResponseEntity<HttpStatus> updatePending(String id) throws Exception {
        try {
            boolean foundTask = todoRepository.existsById(id);
            if(foundTask){
                Optional<Todo> todo = todoRepository.findById(id);
                Todo task = todo.get();
                task.setPending(false);
                task.setCompletedOn(LocalDate.now(ZoneId.systemDefault()));
                todoRepository.save(task);
                return new ResponseEntity<HttpStatus>(HttpStatus.OK);
            }
            return new ResponseEntity<HttpStatus>(HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            System.out.println("Exception thrown: " + e.getMessage());
            throw new Exception(e);
        }
    }

    @Override
    public ResponseEntity<HttpStatus> deleteTask(String id) throws Exception {
        try {
            boolean foundTask = todoRepository.existsById(id);
            if(foundTask){
                todoRepository.deleteById(id);
                return new ResponseEntity<HttpStatus>(HttpStatus.OK);
            }
            return new ResponseEntity<HttpStatus>(HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            System.out.println("Exception thrown: " + e.getMessage());
            throw new Exception(e);
        }
    }
}
