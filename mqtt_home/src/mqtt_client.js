import { connect } from 'mqtt'
const client = connect('mqtt://[[SERVER_IP]]:1883')

// const IRRIGATION = '/irrigation'
const REGISTER = '/register'
const REFRESH = '/refresh'
const UPDATE = '/update'
const STATUS = '/status'
const TEMPERATURE = '/temperature'
// const LIGHT = '/light'
// const SERVICES = '/services'
// const SERVICES_AVAILABLE = [SERVICES, TEMPERATURE, IRRIGATION, LIGHT]

// let state = {}
let boards = {}
let refreshTemperature = undefined

export const init = (updateCallback) => {

  console.log('Starting MQTT client')

  client.on('connect', () => {
    console.log('Connected!')
    client.subscribe(REGISTER)

    //request idle boards
    setTimeout(() => client.publish(REFRESH, JSON.stringify({})), 1000)

  })

  client.on('message', (topic, message) => {
    message = message.toString() || ''
    console.log('Message received', topic, message)

    if(topic === REGISTER) {
      //add the board, subscribe to update topic and get its status
      boards = Object.assign({}, boards, { [message]: {} })
      client.subscribe(message + UPDATE)
      setTimeout( () => client.publish(message + STATUS, JSON.stringify({})), 1000)

    } else if (topic.indexOf(UPDATE) !== -1) {
      //search the board and override its status
      Object.keys(boards)
      .filter((id) => topic === id + UPDATE)
      .forEach((id) => boards = Object.assign({}, boards, { [id]: JSON.parse(message) }))
      updateCallback(boards)
    } else {
      console.log('No handler for topic %s', topic)
    }
    console.log('')
  })

  //requet the temperature every 5 m
  if(!refreshTemperature) {
    const logger = console.log
    refreshTemperature = setInterval(() => {
      logger('Requesting temperature')
      requestTemperature()
    }, 300000)
    requestTemperature()
  }

}

const requestTemperature = () => Object.keys(boards).forEach( key => client.publish(key + TEMPERATURE, "{}"))

export const retrieveBoards = (id = null) => {
  if(id) {
    console.log('retrieving...', id);
    console.log('retrieved', boards[id]);
    return boards[id]
  } else {
    return boards
  }
}

export const callService = ({key, service}) => {
  console.log('Calling service', service, 'for', key)
  if(key && service) {
    client.publish(key + '/' + service, JSON.stringify({}))
    return true
  }
  console.error('id or service not available');
  return false
}


export default client
