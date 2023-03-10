import React, {useState} from 'react';
import {View, Text, StyleSheet, FlatList, Alert} from 'react-native';
import Header from './components/Header';
import ListItem from './components/ListItem';
import AddItem from './components/AddItem';

const App = () => {
  const [items, setItems] = useState([
    {
      id: 0,
      text: 'Milk',
    },
    {
      id: 1,
      text: 'Eggs',
    },
    {
      id: 2,
      text: 'Cakes',
    },
  ]);

  const deleteItem = (id) => {
    setItems((prevItems) => {
      return prevItems.filter((item) => item.id != id);
    });
  };

  const addItem = (txt) => {
    if (!txt) {
      Alert.alert(
        'Error',
        'Please enter item ',
        [{text: 'OK', onPress: () => console.log('OK Pressed')}],
        {cancelable: false},
      );
      return;
    }
    setItems((prevItems) => {
      return [{id: 100, text: txt}, ...prevItems];
    });
  };

  return (
    <View style={styles.container}>
      <Header title="Shopping List" />
      <AddItem addItem={addItem} />
      <FlatList
        keyExtractor={(item) => item.id.toString()}
        data={items}
        renderItem={({item}) => {
          return <ListItem item={item} deleteItem={deleteItem} />;
        }}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 60,
  },
});
export default App;
