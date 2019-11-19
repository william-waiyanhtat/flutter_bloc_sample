import React from 'react';
import {
  SafeAreaView,
  StatusBar,
} from 'react-native';

import FlexDemoScreen from './Layout/FlexDemo';
import TFDemo from './Widgets/TextField/TextFieldDemo';

const App: () => React$Node = () => {
  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView style={{flex:1}}>
       <TFDemo />
      </SafeAreaView>
    </>
  );
};

export default App;
