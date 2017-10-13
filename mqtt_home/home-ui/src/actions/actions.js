export const ADD_BOARD = 'ADD_BOARD'

export const addBoard = (id, board) => {
  return {
    type: ADD_BOARD,
    id,
    board
  }
}
