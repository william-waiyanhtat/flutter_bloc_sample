import React, {useEffect} from 'react';
import {Text} from 'react-native';

const Hello = () => {
  useEffect(() => {
    console.log('Hello');
    return () => {
      console.log('Clean up');
    };
  });
  return <Text>Hello</Text>;
};

export default Hello;
