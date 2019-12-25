import React, {Component} from 'react';
import {View, Text} from 'react-native';

export default class FlexDemoScreen extends Component {
  render() {
    return (
      <View style={{flex: 1}}>
        <View style={{height: 50}}></View>
        {/* <View
          style={{
            flex: 1,
            flexDirection: 'row',
            backgroundColor: 'green',
          }}>
        <View style={{flex:1, flexDirection: 'column', backgroundColor:'green'}}>
        <View style={{flex:1, flexDirection: 'row-reverse', backgroundColor:'green'}}>
        <View style={{flexDirection: 'column-reverse', backgroundColor:'green'}}>
        </View> 
        {/* <View
          style={{
            flex: 1,
            flexDirection: 'column-reverse',
            backgroundColor: 'green',
            justifyContent: 'space-between',
          }}> */}
          {/* <View
          style={{
            flex: 1,
            flexDirection: 'column-reverse',
            backgroundColor: 'green',
            justifyContent: 'center',
          }}> */}
          {/* <View
          style={{
            flex: 1,
            flexDirection: 'column',
            backgroundColor: 'green',
            justifyContent: 'flex-start',
          }}> */}
          {/* <View
          style={{
            flex: 1,
            flexDirection: 'column-reverse',
            backgroundColor: 'green',
            justifyContent: 'flex-end',
          }}> */}
          {/* <View
          style={{
            flex: 1,
            flexDirection: 'row',
            backgroundColor: 'green',
            justifyContent: 'center',
            alignItems: 'flex-start', // remove width
          }}> */}
          <Text>Hello</Text>
          <View
            style={{width: 50, height: 50, backgroundColor: 'powderblue'}}
          />
          <View
            style={{
              width: 50,
              height: 50,
              backgroundColor: 'skyblue',
              alignSelf: 'center',
            }}
          />
          <View
            style={{width: 550, height: 50, backgroundColor: 'steelblue'}}
          />
        </View>
      </View>
    );
  }
}
