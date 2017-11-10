// let path = require('path');
//
// module.exports = {
//   context: './webpack.config.js',
//   entry: "./index.jsx",
//   output: {
//     path: path.resolve('webpack.config.js'),
//     filename: "bundle.js"
//   },
//   module: {
//     loaders: [
//       {
//         test: [/\.jsx?$/, /\.js?$/],
//         exclude: /(node_modules)/,
//         loader: 'babel-loader',
//         query: {
//           presets: ['es2015', 'react']
//         }
//       }
//     ]
//   },
//   devtool: 'source-map',
//   resolve: {
//     extensions: ['.js', '.jsx', '*']
//   }
// };

var path = require('path');

module.exports = {
  context: __dirname,
  entry: "./app.jsx",
  output: {
    path: path.resolve(__dirname),
    filename: "bundle.js"
  },
  module: {
    loaders: [
      {
        test: [/\.jsx?$/, /\.js?$/],
        exclude: /(node_modules)/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015', 'react']
        }
      }
    ]
  },
  devtool: 'source-map',
  resolve: {
    extensions: [".js", ".jsx", "*"]
  }
};
