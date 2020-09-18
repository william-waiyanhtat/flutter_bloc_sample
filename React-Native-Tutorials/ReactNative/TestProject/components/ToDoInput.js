import React, {useState} from 'react';
import {View, TextInput, Button, Text} from 'react-native';
import {useDispatch} from 'react-redux';
import {addToDoAction} from '../redux/redux';
import uuid from 'react-native-uuid';

const ToDoInput = () => {
  const dispatch = useDispatch();
  const [text, setText] = useState('Test');
  const onChangeText = (text) => {
    setText(text);
  };
  const addToDo = () => {
    dispatch(
      addToDoAction({
        id: uuid.v4(),
        name: text,
        completed: false,
      }),
    );
  };
  return (
    <View>
      <Text>Add To Do</Text>
      <TextInput
        style={{height: 40, borderColor: 'gray', borderWidth: 1}}
        onChangeText={(text) => onChangeText(text)}
      />
      <Button title={'Add ToDo'} onPress={() => addToDo()} />
    </View>
  );
};

export default ToDoInput;
