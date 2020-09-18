import React, {useState, useEffect} from 'react';

import {
  View,
  Text,
  SafeAreaView,
  StyleSheet,
  Button,
  FlatList,
  TouchableHighlight,
} from 'react-native';
import {Provider} from 'react-redux';
import {store} from './redux/redux';
import ToDoInput from './components/ToDoInput';
import ToDoList from './components/ToDoList';
import AddItem from './components/AddItem';
import Hello from './components/Hello';
import {useFetch} from './hooks/useFetch';
import Utils from './components/utils';

const App = () => {
  //
  const [show, setShow] = useState(true);
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState({});

  useEffect(() => {
    console.log('Data Loading...');
  }, [loading]);

  return (
    <Provider store={store}>
      <SafeAreaView style={{flex: 1, paddingTop: 50}}>
        <View style={{flex: 1, paddingTop: 100}}>
          {/* <ToDoInput />
          <ToDoList /> */}
          {/* {show && <Hello />} */}
          <Button
            title={'Tap Me'}
            onPress={async () => {
              //setShow(!show);
              // setLoading(!loading);
              // setData({});
              let data = await Utils.getMoviesFromApiAsync();
              console.log(data);
              setData(data);
            }}
          />
          {/* {loading ? (
            <Text>Loading...</Text>
          ) : (
            <FlatList
              data={[{title: 'Title Text', key: 'item1'}]}
              renderItem={({item, index, separators}) => {
                <Text>Hello</Text>;
              }}
            />
          )} */}
          {loading ? (
            <Text>Loading...</Text>
          ) : (
            <FlatList
              data={data.movies}
              renderItem={({item, index, separators}) => (
                <TouchableHighlight
                  key={index}
                  onPress={() => this._onPress(item)}
                  onShowUnderlay={separators.highlight}
                  onHideUnderlay={separators.unhighlight}>
                  <View style={{backgroundColor: 'white'}}>
                    <Text>{item.title}</Text>
                  </View>
                </TouchableHighlight>
              )}
            />
            // <Text>{data.movies.length}</Text>
          )}
        </View>
      </SafeAreaView>
    </Provider>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 60,
  },
});

export default App;
