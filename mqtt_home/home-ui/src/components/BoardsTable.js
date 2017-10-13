import React, { Component } from 'react'
import {Table, TableBody, TableHeader, TableHeaderColumn, TableRow, TableRowColumn} from 'material-ui/Table'
import { EditIcon, LightIcon, IrrigationIcon, TemperatureWidget, StatusIcon, getIdFromKey } from './Commons'
//import { runService, fetchBoards } from '../utils/services-utils'
import socket from '../utils/socket'

const headers = ['ID', 'Location', 'Temperature', 'Light', 'Irrigation', 'Status', 'Edit']

class BoardsTable extends Component {

  componentDidMount() {
    socket.on('connect', () => console.log('connected'))
    socket.on('disconnect', () => console.log('disconnected'))
    socket.on('boards:response:all', (boards) => {
      console.log('boards:response:all', boards)
      Object.keys(boards)
      .forEach( k => this.props.refreshBoard(k, boards[k]) )
    })
    socket.emit('boards:request:all', {})
  }

  cellClicked(row, col) {
    const key = this.children[1].props.children[row].key
    console.log(key, headers[col-1].toLowerCase())
    socket.emit('boards:service:call',
      {
        id: socket.id,
        key,
        service: headers[col-1].toLowerCase()
      }
    )
  }

  render() {
    const {boards} = this.props
    return <Table onCellClick={this.cellClicked}>
      <TableHeader displaySelectAll={false} adjustForCheckbox={false}>
        <TableRow>
          {headers.map( h => <TableHeaderColumn key={h}>{h}</TableHeaderColumn>)}
        </TableRow>
      </TableHeader>
      <TableBody displayRowCheckbox={false}>
        {
          Object.keys(boards)
          .map( k => {
              return <TableRow key={k}>
                <TableRowColumn>{getIdFromKey(k)}</TableRowColumn>
                <TableRowColumn>{boards[k].location}</TableRowColumn>
                <TableRowColumn><TemperatureWidget temperature={boards[k].temperature} /></TableRowColumn>
                <TableRowColumn><LightIcon status={boards[k].light} /></TableRowColumn>
                <TableRowColumn><IrrigationIcon status={boards[k].irrigation} /></TableRowColumn>
                <TableRowColumn><StatusIcon status={boards[k].status} /></TableRowColumn>
                <TableRowColumn><EditIcon /></TableRowColumn>
              </TableRow>
          })
        }
      </TableBody>
    </Table>
  }
}

export default BoardsTable
