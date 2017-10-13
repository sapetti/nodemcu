import React from 'react'
import ActionLightbulbOutline from 'material-ui/svg-icons/action/lightbulb-outline'
import ActionPowerSettingsNew from 'material-ui/svg-icons/action/power-settings-new'
import EditorModeEdit from 'material-ui/svg-icons/editor/mode-edit'
import ActionInvertColors from 'material-ui/svg-icons/action/invert-colors'
import Chip from 'material-ui/Chip'
import { black500, blue300, green300, green500, grey300, grey500, red500 } from 'material-ui/styles/colors'

function getColor(status, down = red500, up = green500) {
  return status === undefined || status === null || status === 'disabled' ?  grey500
        : status === 1 || status === 'up' ? up
        : down
}

export const getIdFromKey = (key) => key.split('/')[2]

export const LightIcon = ({status}) =>  <ActionLightbulbOutline color={ getColor(status) } />

export const EditIcon = () => <EditorModeEdit color={black500} />

export const IrrigationIcon = ({status}) => <ActionInvertColors color={getColor(status, blue300)} />

export const TemperatureWidget = ({temperature}) => {
  let returnVal = typeof(temperature) == 'number' ? temperature.toFixed(2) + 'º' : '-'
  return <Chip backgroundColor={grey300}>{ returnVal }</Chip>
}

export const StatusIcon = ({status}) => <ActionPowerSettingsNew color={getColor(status)} />
