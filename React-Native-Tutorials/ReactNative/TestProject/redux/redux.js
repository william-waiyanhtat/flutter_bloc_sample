import {createStore, applyMiddleware} from 'redux';
import thunk from 'redux-thunk';
import {uuid} from 'react-native-uuid';

const initialState = {
  todos: [
    // {
    //   id: 0,
    //   name: 'Test ToDo 1',
    //   completed: false,
    // },
    // {
    //   id: 1,
    //   name: 'Test ToDo 2',
    //   completed: true,
    // },
  ],
};

export const store = createStore(reducer, applyMiddleware(thunk));

function reducer(state = initialState, {type, payload}) {
  // console.log('type ' + JSON.stringify(payload));
  switch (type) {
    case 'ADD-TODO':
      return {...state, todos: [...state.todos, payload]};
    case 'TOGGLE-TODO':
      return {
        ...state,
        todos: state.todos.map((todo) =>
          todo.id === payload.todoId
            ? {...todo, completed: !todo.completed}
            : todo,
        ),
      };
    case 'DELETE-TODO':
      console.log('delete' + payload);
      return {
        ...state,
        todos: state.todos.filter((todo) => todo.id !== payload.todoId),
      };
    default:
      return state;
  }
}

export const addToDoAction = (todo) => ({
  type: 'ADD-TODO',
  payload: todo,
});

export const toggleToDoAction = (todoId) => ({
  type: 'TOGGLE-TODO',
  payload: todoId,
});

export const deleteToDoAction = (todoId) => ({
  type: 'DELETE-TODO',
  payload: todoId,
});
