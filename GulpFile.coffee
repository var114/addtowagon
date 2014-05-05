gulp = require('gulp')
sass = require('gulp-sass')
livereload = require('gulp-livereload')
express = require('express')
watch = require('gulp-watch')
nodemon = require('gulp-nodemon')
plumber = require('gulp-plumber')
browserify = require('gulp-browserify')
rename = require('gulp-rename')
prefix = require('gulp-autoprefixer')

gulp.task 'default', () ->
  server = livereload() 

  nodemon({
    script: 'app/app.coffee',
    ext: 'coffee',
    env: { 'NODE_ENV':  'development' , 'PORT': 4000},
    watch: 'app',
    ignore: [ "Gulpfile.coffee"]
  }).on 'restart', () -> console.log 'Restarted Server!'
  
  watch { glob: 'app/css/**/*.scss' }, () ->
    gulp.src('app/css/master.scss')
      .pipe(plumber())
      .pipe(sass({
        errLogToConsole: true,
        includePaths: ['./']
        }))
      .pipe(prefix("last 1 version", "> 1%", "ie 8", "ie 7"))
      .pipe(rename({
        dirname: "css"
        }))
      .pipe(gulp.dest('./build'))
      .pipe(livereload())

  watch { glob: 'app/js/**/*.coffee' }, () ->
    gulp.src(['app/js/master.coffee', 'app/js/jrnl/jrnl.coffee'], { read: false })
      .pipe(plumber())
      .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']
      }))
      .pipe(rename({
        dirname: "js",
        extname: ".js"
        }))
      .pipe(gulp.dest('./build'))
      .pipe(livereload())

  watch { glob: 'app/views/**/*.jade' }
    .pipe(plumber())
    .pipe(livereload())