module.exports = {
  entry: ['./src/ls/app.ls'],
  output: {
    path: __dirname + '/extension/js',
    filename: 'ideahub.js'
  },
  resolve: {
    extensions: ['', '.js', '.ls']
  },
  module: {
    loaders: [
      { test: /\.ls$/, loaders: ['livescript-loader'] }
    ]
  },
  plugins: []
}