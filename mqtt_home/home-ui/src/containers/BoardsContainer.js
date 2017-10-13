import { connect } from 'react-redux'
import { addBoard } from '../actions/actions'
import BoardsTable from '../components/BoardsTable'

const mapStateToProps = (state) => {
  return {
    boards: state.boards
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    refreshBoard: (id, board) => {
      dispatch(addBoard(id, board))
    }
  }
}

const BoardsContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(BoardsTable)

export default BoardsContainer
