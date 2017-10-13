import React from 'react';
import {Card, CardTitle, CardText} from 'material-ui/Card';

import BoardsContainer from '../containers/BoardsContainer'

const ContentCard = () => (
  <Card>
    <CardTitle title="Available boards" />

    <BoardsContainer />

    <CardText>
      Select a card to interact with it.
    </CardText>
  </Card>
)

export default ContentCard
