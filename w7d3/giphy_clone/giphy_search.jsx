import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';
import { fetchSearchGiphys } from './util/api_util';
// first bug...forgot to put the method on the window so I had access to it
// in the browser console! D'oh!

// REMOVE THESE BEFORE PRODUCTION
window.fetchSearchGiphys = fetchSearchGiphys;
// REMOVE THESE BEFORE PRODUCTION
