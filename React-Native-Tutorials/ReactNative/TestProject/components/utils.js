class Utils {
  static getMoviesFromApiAsync = async () => {
    try {
      let response = await fetch('https://reactnative.dev/movies.json');
      let json = await response.json();
      console.log(json);
      return json;
    } catch (error) {
      //   console.error(error);
      return error;
    }
  };
}

export default Utils;
