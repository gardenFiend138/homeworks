import * as APIUtil from '../util/api_util';

export const  REQUEST_SEARCH_GIPHYS = 'REQUEST_SEARCH_GIPHYS';
export const  RECEIVE_SEARCH_GIPHYS = 'RECEIVE_SEARCH_GIPHYS';

const fetchSearchGiphys = (searchTerm) => dispatch => {
    return APIUtil.fetchSearchGiphys(searchTerm)
           .then(giphys => dispatch(receiveSearchGiphys(giphys.data)));
  }
};

const receiveSearchGiphys = (giphys) => {
  return {
    type: RECEIVE_SEARCH_GIPHYS,
    giphys
  }
};

export default fetchSearchGiphys;
export default receiveSearchGiphys;
