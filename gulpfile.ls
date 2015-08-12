gulp = require \gulp
webpack = require \webpack
stylus = require \gulp-stylus
gutil = require \gulp-util


paths = 
  ls: \./src/ls/app.ls
  lsAll: \./src/ls/*.ls
  js: \./extension/js
  styl: \./src/styl/main.styl
  stylAll: \./src/styl/*.styl
  css: \./extension/css

webpack-config = require(\./webpack.config)

gulp.task \webpack, (cb)->
  prod-config = Object.create webpack-config
  prod-config.plugins = prod-config.plugins.concat new webpack.optimize.UglifyJsPlugin()
  webpack prod-config, (err, stats) ->
     gutil.log '[webpack]', stats.toString!
     cb!

gulp.task \webpack-dev, (cb)->
  webpack webpack-config, (err, stats) ->
     gutil.log '[webpack]', stats.toString!
     cb!

gulp.task \styl, ->
  gulp.src paths.styl
    .pipe stylus!
    .pipe gulp.dest paths.css

gulp.task \watch, ->
  gulp.watch paths.lsAll, <[webpack-dev]>
  gulp.watch paths.stylAll, <[styl]>

gulp.task \build, <[webpack styl]>

gulp.task \build-dev, <[webpack-dev styl]>

gulp.task \default, <[build watch]>

gulp.task \dev, <[build-dev watch]>