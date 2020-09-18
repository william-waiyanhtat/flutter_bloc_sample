import {useEffect, useState} from 'react';

export const useFetch = (url) => {
  const [response, setResponse] = useState({data: null, loading: true});
  useEffect(() => {
    setResponse({data: response.data, loading: true});
    const getNumber = async () => {
      return await fetch(url).then((response) =>
        response.json().then((json) => {
          console.log(json);
          setResponse({data: json, loading: false});
        }),
      );
    };
    getNumber();
  }, [url]);

  return response;
};
