import { ADD_BOARD } from '../actions/actions'

// const board = (state = {}, action) => {
//   switch (action.type) {
//     default:
//       return state
//   }
// }

const boards = (state = {}, action) => {
  switch (action.type) {
    case 'ADD_BOARD':
      return Object.assign({}, state, { [action.id]: action.board })
    default:
      return state
  }
}

export default boards
