import React from 'react';
import {View, Text, StyleSheet} from 'react-native';

const Header = ({title}) => {
  return (
    <View style={styles.header}>
      <Text style={styles.text}>{title}</Text>
    </View>
  );
};

Header.defaultProps = {
  title: 'Hello',
};

const styles = StyleSheet.create({
  header: {
    height: 60,
    backgroundColor: 'darkslateblue',
    justifyContent: 'center',
  },
  text: {
    color: '#FFFFFF',
    fontSize: 30,
    textAlign: 'center',
  },
});
export default Header;
