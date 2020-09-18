import React, {useState} from 'react';
import {View, Text, TextInput, StyleSheet, Button} from 'react-native';
import Icon from 'react-native-vector-icons/dist/FontAwesome';

const AddItem = ({addItem}) => {
  const [text, setText] = useState('');

  const onChangeText = (txt) => {
    console.log(txt);
    setText(txt);
  };

  return (
    <View>
      <TextInput
        style={styles.tinputStyle}
        placeholder={'Add Item...'}
        onChangeText={(txt) => onChangeText(txt)}
      />
      <Button title={'Add'} onPress={() => addItem(text)} />
    </View>
  );
};
const styles = StyleSheet.create({
  tinputStyle: {
    padding: 20,
  },
});
export default AddItem;
