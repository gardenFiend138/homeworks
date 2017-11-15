export const fetchSearchGiphys = (searchTerm) => (
  $.ajax({
    method: 'GET',
    url: 'http://api.giphy.com/v1/gifs/search?q=' +
         `${searchTerm}&api_key=7qFuVG0DKr6g1gFd16NQX5WR2gumxc76&limit=2`
  })
);
