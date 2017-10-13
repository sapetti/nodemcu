import React, { Component } from 'react'
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider'
import injectTapEventPlugin from 'react-tap-event-plugin'
import getMuiTheme from 'material-ui/styles/getMuiTheme'
import lightBaseTheme from 'material-ui/styles/baseThemes/lightBaseTheme'

import TopBar from './TopBar'
import ContentCard from './ContentCard'

// import { fetchBoards } from '../utils/servicesUtils'

// Needed for onTouchTap
// http://stackoverflow.com/a/34015469/988941
injectTapEventPlugin();

class App extends Component {

  // componentDidMount() {
  //   fetchBoards()
  // }

  render() {
    return (
        <MuiThemeProvider muiTheme={ getMuiTheme(lightBaseTheme) }>
          <div>
            <TopBar />
            <div>
              <ContentCard />
            </div>
          </div>
        </MuiThemeProvider>
    );
  }
}

export default App
