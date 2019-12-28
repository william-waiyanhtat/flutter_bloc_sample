import React, {Component} from 'react';
import {View, Text, FlatList, Button} from 'react-native';
import {ListItem, SearchBar} from 'react-native-elements';

class FlatListDemo extends Component {
  constructor(props) {
    super(props);
    this.state = {
      loading: false,
      data: [],
      temp: [],
      error: null,
      searchTxt: null,
    };
  }

  componentDidMount() {
    this.getData();
  }

  getData = async () => {
    const url = 'https://jsonplaceholder.typicode.com/users';
    this.setState({loading: true});
    try {
      const response = await fetch(url);
      const json = await response.json();
      this.setResult(json);
    } catch (e) {
      this.setState({loading: false, error: 'Error Loading Users.'});
    }
  };

  setResult = res => {
    this.setState({
      data: res, //[...this.state.data, ...res],
      temp: [...this.state.temp, ...res],
      error: res.error || null,
      loading: false,
    });
  };

  renderHeader = () => {
    return (
      <SearchBar
        placeholder="Search Here..."
        lightTheme
        round
        editable={true}
        value={this.state.searchTxt}
        onChangeText={this.updateSearch}
      />
    );
  };

  updateSearch = searchTxt => {
    this.setState({searchTxt}, () => {
      if ('' == searchTxt) {
        this.setState({
          data: this.state.temp, //[...this.state.temp],
        });
        return;
      }
      this.state.data = this.state.temp
        .filter(function(item) {
          return item.name.includes(searchTxt);
        })
        .map(function({id, name, email}) {
          return {id, name, email};
        });
    });
  };

  render() {
    return this.state.error != null ? (
      <View
        style={{
          flex: 1,
          flexDirection: 'column',
          justifyContent: 'center',
          alignItems: 'center',
        }}>
        <Text>{this.state.error}</Text>
        <Button title="Reload" onPress={this.getData} />
      </View>
    ) : (
      <FlatList
        ListHeaderComponent={this.renderHeader}
        data={this.state.data}
        keyExtractor={item => item.email}
        renderItem={({item}) => (
          <ListItem title={item.name} subtitle={item.email} />
        )}
      />
    );
  }
}

export default FlatListDemo;
