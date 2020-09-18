import 'react-native';
import React from 'react';
import App from '../App';
import {sum} from '../functions';
import ToDoInput from '../components/ToDoInput';
import renderer from 'react-test-renderer';
import {render, fireEvent} from '@testing-library/react-native';
import axios from 'axios';
import Utils from '../components/utils';

jest.mock('axios');

test('Test Getting Movies', async () => {
  const movies = [
    {id: '1', releaseYear: '1977', title: 'Star Wars'},
    {id: '2', releaseYear: '1985', title: 'Back to the Future'},
    {id: '3', releaseYear: '1999', title: 'The Matrix'},
    {id: '4', releaseYear: '2010', title: 'Inception'},
    {id: '5', releaseYear: '2014', title: 'Interstellar'},
  ];
  const response = {movies: movies};
  axios.get.mockResolvedValue(response);

  function callback(data) {
    try {
      expect(data).toEqual(response), done();
    } catch (error) {
      done(error);
    }
  }
  Utils.getMoviesFromApiAsync(callback);
});

test('Test Getting Movies 2', async () => {
  const movies = [
    {id: '1', releaseYear: '1977', title: 'Star Wars'},
    {id: '2', releaseYear: '1985', title: 'Back to the Future'},
    {id: '3', releaseYear: '1999', title: 'The Matrix'},
    {id: '4', releaseYear: '2010', title: 'Inception'},
    {id: '5', releaseYear: '2014', title: 'Interstellar'},
  ];
  const response = {movies: movies};
  axios.get.mockResolvedValue(response);
  return Utils.getMoviesFromApiAsync().then((movies) => {
    console.log(movies);
    expect(movies).toEqual(response);
  });
});

// test('the fetch fails with an error', async () => {
//   // expect.assertions(1);
//   return await Utils.getMoviesFromApiAsync().catch((e) =>
//     expect(e).toMatch('error'),
//   );
// });

/*

test('Testing Snapshot of Component', () => {
  const root = render(<App />);
  expect(root).toMatchSnapshot();
});

test('Testing ToDoInput In App', () => {
  const instance = renderer.create(<App />);
  const todoInput = instance.root.findByType(ToDoInput);
  expect(todoInput).toBeDefined();
});

test('Testing Funtion', () => {
  expect(sum(1, 2)).toEqual(3);
});

*/
