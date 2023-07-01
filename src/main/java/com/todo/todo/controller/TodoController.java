package com.todo.todo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.todo.todo.model.Entity.Todo;
import com.todo.todo.model.POJO.TodoPojo;
import com.todo.todo.service.TodoServiceImpl;

@RestController
@RequestMapping(value = "/api/v1/")
public class TodoController {
    @Autowired
    private TodoServiceImpl todoServiceImpl;

    @PostMapping(value = "create", headers = {"content-type=application/json"})
    public void saveTask(@RequestBody TodoPojo todoPojo) throws Exception {
        System.out.println("Saving data!!!");
        ResponseEntity<HttpStatus> responseEntity = todoServiceImpl.saveTask(todoPojo);
        if(responseEntity.getStatusCode() == HttpStatus.OK){
            System.out.println("Data saved successfully!!!");
        }else{
            System.out.println("Data not saved in the database!!!");
        }
    }

    @GetMapping(value = "tasks")
    public List<Todo> getAllTasks() throws Exception{
        System.out.println("Retrieving all the data!!!");
        return todoServiceImpl.getTasks();
    }

    @PutMapping(value = "task/{id}", headers = {"content-type=application/json"})
    public void updateTask(@PathVariable String id, @RequestBody TodoPojo todoPojo) throws Exception{
        System.out.println("Updating data!!!");
        ResponseEntity<HttpStatus> responseEntity = todoServiceImpl.updateTask(id, todoPojo);
        if(responseEntity.getStatusCode() == HttpStatus.OK){
            System.out.println("Data updated successfully!!!");
        }else{
            System.out.println("Data not updated in the database!!!");
        }
    }

    @PutMapping(value = "task/pending/{id}", headers = {"content-type=application/json"})
    public void updatePending(@PathVariable String id) throws Exception{
        System.out.println("Updating pending data!!!");
        ResponseEntity<HttpStatus> responseEntity = todoServiceImpl.updatePending(id);
        if(responseEntity.getStatusCode() == HttpStatus.OK){
            System.out.println("Data updated successfully!!!");
        }else{
            System.out.println("Data not updated in the database!!!");
        }
    }

    @DeleteMapping(value = "task/{id}")
    public void deleteTask(@PathVariable String id) throws Exception{
        System.out.println("Deleting the data!!!");
        ResponseEntity<HttpStatus> responseEntity = todoServiceImpl.deleteTask(id);
        if(responseEntity.getStatusCode() == HttpStatus.OK){
            System.out.println("Data deleted successfully!!!");
        }else{
            System.out.println("Data not deleted in the database!!!");
        }
    }
}
