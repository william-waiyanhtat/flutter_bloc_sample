import React, { Component } from 'react';
import { View, Text, TextInput } from 'react-native';

var value = 'hello';

export default class FlexDemoScreen extends Component {
    render() {
        return (
            <View style={{flex:1}}>
                <View style={{ height: 50 }}></View>
                  <TextInput
                    style={{ height: 40, borderColor: 'gray', borderWidth: 1 }}
                    onChangeText={text => onChangeText(text)}
                    value={value}
                    />
            </View>
        )
    }
}