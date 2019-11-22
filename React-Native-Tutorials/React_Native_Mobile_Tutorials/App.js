import React from 'react';
import {
  SafeAreaView,
  StatusBar,
} from 'react-native';

// import FlexDemoScreen from './Layout/FlexDemo';
import FlatListDemo from './Widgets/FlastLIst/FlastListDemo';

const App: () => React$Node = () => {
  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView style={{flex:1}}>
       <FlatListDemo />
      </SafeAreaView>
    </>
  );
};

export default App;
