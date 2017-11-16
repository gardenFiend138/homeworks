import { RECEIVE_SEARCH_GIPHYS } from '../actions/giphy_actions';

// why do we use an array here for the state isntead of a hash?
const giphysReducer = (state = [], action) => {
  Object.freeze(state);
  // let nextState; //not needed yet...will when there are more actions;

  switch (action.type) {
    case  RECEIVE_SEARCH_GIPHYS:
      return action.giphys;
    default:
      return state;
  }
};

export default giphysReducer;
