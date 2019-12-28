import React from 'react';
import {SafeAreaView, StatusBar, View} from 'react-native';

import FlatListDemo from './Widgets/FlastList/FlatListDemo';

const App: () => React$Node = () => {
  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView style={{flex: 1}}>
        <FlatListDemo />
      </SafeAreaView>
    </>
  );
};

export default App;
