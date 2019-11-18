import React, { Component } from 'react';
import { View, Text } from 'react-native';

export default class Homescreen extends Component {
    render() {
        return (
            <View style={{flex:1}}>
                <View style={{ height: 50 }}></View>
                {/* <View style={{flex:1, flexDirection: 'row', backgroundColor:'red'}}> */}
                {/* <View style={{flex:1, flexDirection: 'column', backgroundColor:'red'}}> */}
                {/* <View style={{flex:1, flexDirection: 'row-reverse', backgroundColor:'red'}}> */}
                {/* <View style={{flexDirection: 'column-reverse', backgroundColor:'red'}}> */}
                {/* <View style={{
                    flex: 1,
                    flexDirection: 'column-reverse',
                    backgroundColor: 'red',
                    justifyContent: 'space-between'
                }}> */}
                {/* <View style={{
                    flex: 1,
                    flexDirection: 'column-reverse',
                    backgroundColor: 'red',
                    justifyContent: 'center'
                }}> */}
                {/* <View style={{
                    flex: 1,
                    flexDirection: 'column',
                    backgroundColor: 'red',
                    justifyContent: 'flex-start'
                }}> */}
                {/* <View style={{
                    flex: 1,
                    flexDirection: 'column-reverse',
                    backgroundColor: 'red',
                    justifyContent: 'flex-end'
                }}> */}
                {/* <View style={{
                    flex: 1,
                    flexDirection: 'row',
                    backgroundColor: 'red',
                    justifyContent: 'center',
                    alignItems: 'flex-start' // remove width
                }}>
                <Text>Hello</Text>
                  <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
                    <View style={{width: 50, height: 50, backgroundColor: 'skyblue', alignSelf:'center'}} />
                    <View style={{ width: 550, height: 50, backgroundColor: 'steelblue' }} />
                    
            </View> */}
                
            <View style={{
                    flex: 1,
                    flexWrap:'wrap', //wrap, nowrap
                    flexDirection: 'row',
                    backgroundColor: 'red',
                    justifyContent: 'center',
                    alignItems: 'flex-start' // remove width
                }}>
                    {/* <Text style={{ width: '30%' }}>Hello</Text> */}
                    <Text style={{ width: 'auto' }}>Hello</Text>
                  <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
                    {/* <View style={{width: 50, height: 50, backgroundColor: 'skyblue'}} /> */}
                    {/* <View style={{width: '20%', height: 50, backgroundColor: 'skyblue', alignSelf:'center'}} /> */}
                    <View style={{width: '20%', height: 50, backgroundColor: 'skyblue', alignSelf:'center'}} />
                    <View style={{ width: 550, height: 50, backgroundColor: 'steelblue' }} />
                    
                </View>
            </View>
        )
    }
}