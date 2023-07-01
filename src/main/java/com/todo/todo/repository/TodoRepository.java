package com.todo.todo.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.todo.todo.model.Entity.Todo;

@Repository
public interface TodoRepository extends MongoRepository<Todo, String>{
    
}
