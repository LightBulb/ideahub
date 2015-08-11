gulp = require \gulp
live = require \gulp-livescript
stylus = require \gulp-stylus

paths = 
  ls: \./src/ls/app.ls
  lsAll: \./src/ls/*.ls
  js: \./extension/js
  styl: \./src/styl/main.styl
  stylAll: \./src/styl/*.styl
  css: \./extension/css

gulp.task \js, ->
  gulp.src paths.ls
    .pipe live bare: true
    .pipe gulp.dest paths.js

gulp.task \styl, ->
  gulp.src paths.styl
    .pipe stylus!
    .pipe gulp.dest paths.css

gulp.task \watch, ->
  gulp.watch paths.lsAll, <[js]>
  gulp.watch paths.stylAll, <[styl]>

gulp.task \build, <[js styl]>

gulp.task \default, <[build watch]>