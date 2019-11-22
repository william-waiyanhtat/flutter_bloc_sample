import React, { Component } from "react";
import { View, Text, FlatList } from "react-native";
import { List, ListItem, SearchBar } from "react-native-elements";

class FlatListDemo extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loading: false,
        data: [],
      temp: [],
      page: 1,
      seed: 1,
      error: null,
        refreshing: false,
      search: '',
    };
  }

  componentDidMount() {
    this.makeRemoteRequest();
  }

  makeRemoteRequest = () => {
    const { page, seed } = this.state;
    const url = `https://jsonplaceholder.typicode.com/users`;
    this.setState({ loading: true });
    fetch(url)
      .then(res => res.json())
        .then(res => {
          console.log("result : " + res[0].id);
          this.setState({
              data: [...this.state.data, ...res],
              temp: [...this.state.temp, ...res],
            error: res.error || null,
            loading: false,
            refreshing: false
          });
      })
      .catch(error => {
        this.setState({ error, loading: false });
      });
  };

  renderHeader = () => {
      return <SearchBar placeholder="Search Here..."
          lightTheme round editable={true}
          value={this.state.search}
          onChangeText={this.updateSearch} />;
  };

    updateSearch = search => {
        this.setState({ search }, () => {
            if ('' == search) {
                this.setState({
                    data: [...this.state.temp]
                });
                return;
            }
            
            this.state.data = this.state.temp.filter(function(item){
                return item.name.includes(search);
              }).map(function({id, name, email}){
                return {id, name, email};
            });
        });
   };

  render() {
    return (
        <FlatList
            ListHeaderComponent={this.renderHeader}
            data={this.state.data}
            keyExtractor={item => item.email}
            renderItem={({ item }) => (
            <ListItem
                roundAvatar
                title={`${item.name}`}
                subtitle={item.email}
                // avatar={{ uri: item.picture.thumbnail }}
            />
        )}
      />
        // <View />
            
    );
  }
}

export default FlatListDemo;