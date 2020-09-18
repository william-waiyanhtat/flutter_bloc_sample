import React, {useState} from 'react';
import {View, TextInput, Button, Text} from 'react-native';
import {useSelector, useDispatch} from 'react-redux';
import {
  addToDoAction,
  deleteToDoAction,
  toggleToDoAction,
} from '../redux/redux';
import uuid from 'react-native-uuid';

const ToDoInput = () => {
  const todos = useSelector((state) => state.todos);
  const dispatch = useDispatch();
  const deleteToDo = (todoId) => {
    dispatch(
      deleteToDoAction({
        todoId,
      }),
    );
  };
  const toggleToDo = (todoId) => {
    dispatch(
      toggleToDoAction({
        todoId,
      }),
    );
  };

  return (
    <View>
      {todos.map((todo) => (
        <View
          style={{
            flexDirection: 'row',
            justifyContent: 'space-between',
            padding: 10,
          }}>
          <Text>{todo.name}</Text>
          <Text>{todo.completed ? 'completed' : 'not'}</Text>
          <Button title={'Delete'} onPress={() => deleteToDo(todo.id)} />
          <Button title={'toggle'} onPress={() => toggleToDo(todo.id)} />
        </View>
      ))}
    </View>
  );
};

export default ToDoInput;
