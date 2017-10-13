import express from 'express'
import http from 'http'
import socket from 'socket.io'
import { init, retrieveBoards, callService } from './mqtt_client'

const app = express()
const server = http.Server(app)
const io = socket(server)

//return ui
app.use(express.static('home-ui/build'));

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/home-ui/build/index.html')
})

//handle socket.io connections
io.on('connection', (socket) => {
  console.log('ui connected', socket.id)

  socket.on('boards:request:all', () => {
    socket.emit('boards:response:all', retrieveBoards())
  })

  socket.on('boards:service:call', (data) => callService(data))

  socket.on('disconnect', () => console.log('ui disconnected'))
})

//this function will handle the response from mqtt
const updateCallback = (boards) => {
  console.log('updateCallback')
  io.sockets.emit('boards:response:all', boards)
}

//startup server
server.listen(3030, () => {
  console.log('Home automation server listening on port 3030!')
  init(updateCallback)
})
