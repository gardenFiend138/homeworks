import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';
import { fetchSearchGiphys } from './util/api_util';
import fetchSearchGiphys from './actions/giphy_actions'
// first bug...forgot to put the method on the window so I had access to it
// in the browser console! D'oh!

// REMOVE THESE BEFORE PRODUCTION
window.fetchSearchGiphys = fetchSearchGiphys;

// REMOVE THESE BEFORE PRODUCTION

document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore();
  const root = document.getElementById('root');
  // ReactDOM.render(<Root store={ store } />, root);

  // REMOVE THIS BEFORE PRODUCTION
  window.store = store;
  // REMOVE THIS BEFORE PRODUCTION
});
