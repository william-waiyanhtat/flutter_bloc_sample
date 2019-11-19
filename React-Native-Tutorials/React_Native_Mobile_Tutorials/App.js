import React from 'react';
import {
  SafeAreaView,
  StatusBar,
} from 'react-native';

import FlexDemoScreen from './Layout/FlexDemo';

const App: () => React$Node = () => {
  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView style={{flex:1}}>
       <FlexDemoScreen />
      </SafeAreaView>
    </>
  );
};

export default App;
