express = require 'express'
path = require 'path'
jade = require 'jade'
multer = require 'multer'
fs = require 'fs'

app = express()
server = require('http').createServer(app)

app.set('port', process.env.PORT || 4567)
app.set('view engine', 'jade')
app.set('views', path.join(__dirname, 'views'))

app.use(express.bodyParser());
app.use(express.static(path.join(__dirname, '../build')))
app.use(express.static(path.join(__dirname, '/views')))

app.get '/', (req, res) -> res.render 'index'
app.get '/archive', (req, res) -> res.render 'archive'
console.log 'return archive'
app.get '/about', (req, res) -> res.render 'about'
  


# listening on server
server.listen (app.get 'port'), () ->
 console.log 'listening on Server 4000'