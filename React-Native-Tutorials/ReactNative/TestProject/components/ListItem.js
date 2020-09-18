import React from 'react';
import {View, Text, StyleSheet, TouchableOpacity} from 'react-native';
import Icon from 'react-native-vector-icons/dist/FontAwesome';

const ListItem = ({item, deleteItem}) => {
  return (
    <TouchableOpacity style={styles.listItemStyle}>
      <View style={styles.listItemViewStyle}>
        <Text>{item.text}</Text>
        <Icon name="remove" size={20} onPress={() => deleteItem(item.id)} />
      </View>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  listItemStyle: {
    padding: 15,
  },
  listItemViewStyle: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  text: {
    color: '#FFFFFF',
    fontSize: 30,
    textAlign: 'center',
  },
});
export default ListItem;
