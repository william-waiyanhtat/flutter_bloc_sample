import React, { Component } from 'react';
import { View, Text, TextInput, Button } from 'react-native';


var textInput = React.createRef();
export default class TFDemo extends Component {


    render() {
        return (
            <View style={{flex:1}}>
                <View style={{ height: 50 }}>

                </View>
                {/* <UselessTextInput /> */}
                <TextInput
          ref={input => { this.textInput = input }}
          editable={true}
          autoFocus={false}
          blurOnSubmit={true}
          clearTextOnFocus={true}
          dataDetectorTypes="phoneNumber"
          clearButtonMode='always'
          defaultValue='Hello'
          enablesReturnKeyAutomatically={true}
          importantForAutofill='auto'
          inlineImageLeft='ic_launcher'
          keyboardAppearance='dark'
          keyboardType='default' //default
          placeholder='Place Holder'
          placeholderTextColor='red'
          returnKeyType='done'
          textContentType='addressCity'
          maxLength={10}
          style={{
              height: 40,
              borderColor: 'gray',
              borderWidth: 1,
              padding: 1,
              margin:20
          }}
          // multiline
          // numberOfLines={ 1 }
          onChangeText={text => onChangeText(text)}
    />
                <Text>Hello</Text>
                <Button title='CLick' onPress={() => this.textInput.clear() } />
            </View>
        )
    }
}

function UselessTextInput() {
    
  const [value, onChangeText] = React.useState('Useless Placeholder');

  return (
      <TextInput
          ref={input => { this.textInput = input }}
          editable={true}
          autoFocus={false}
          blurOnSubmit={true}
          clearTextOnFocus={true}
          dataDetectorTypes="phoneNumber"
          clearButtonMode='always'
          defaultValue='Hello'
          enablesReturnKeyAutomatically={true}
          importantForAutofill='auto'
          inlineImageLeft='ic_launcher'
          keyboardAppearance='dark'
          keyboardType='default' //default
          placeholder='Place Holder'
          placeholderTextColor='red'
          returnKeyType='done'
          textContentType='addressCity'
          maxLength={10}
          style={{
              height: 40,
              borderColor: 'gray',
              borderWidth: 1,
              padding: 1,
              margin:20
          }}
          // multiline
          // numberOfLines={ 1 }
          onChangeText={text => onChangeText(text)}
          value={value}
    />
  );
}