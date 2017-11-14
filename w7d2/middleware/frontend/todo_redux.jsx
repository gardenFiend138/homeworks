import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  const store = configureStore(preloadedState);

  // store.dispatch = addLoggingToDispatch(store); // Step 1--Logging store
  // store = applyMiddleWares(store, addLoggingToDispatch); // refactor step 1

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});

// Step 1--Logging our store
// const addLoggingToDispatch = (store) => {
//   const storeDispatch = store.dispatch;
//   return (action) => {
//     console.log(store.getState());
//     console.log(action);
//     storeDispatch(action);
//     console.log(store.getState());
//   };
// };

// Step 2-- Creating middleware (ES6 notation) (curried function)
// moved to './store/store.js'
// const addLoggingToDispatch = store => next => action => {
//   console.log(store.getState());
//   console.log(action);
//   next(action);
//   console.log(store.getState());
// };

const applyMiddleWares = (store, ...middlewares) => {
  let dispatch = store.dispatch;
  middlewares.forEach((middleware) => {
    dispatch = middleware(store)(dispatch);
  });

  return Object.assign({}, store, { dispatch });
};

// Step 2--Creating middleware; below is ES5 notation; we will be using
// ES6 arrow notation (see above).

// function addLoggingToDispatch(store) {
//   return function(next) {
//     return function(action) {
//
//     };
//   };
// };
