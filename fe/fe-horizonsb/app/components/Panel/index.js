import React from 'react'
import PropTypes from 'prop-types'
import { formatNumber } from '../../utils/helpers'
import { SpinnerIcon } from '../../assets/icons'
import { Panel, PanelContainer, PanelTitle, PanelValue } from './styled'

const PanelItem = ({ title, value, isActive }) => (
  <PanelContainer isActive={isActive}>
    <PanelTitle>{title}</PanelTitle>
    <PanelValue>
      {Number.isInteger(value) ? formatNumber(value) : <SpinnerIcon />}
    </PanelValue>
  </PanelContainer>
)

PanelItem.defaultProps = {
  value: null,
  isActive: true,
}

PanelItem.propTypes = {
  isActive: PropTypes.bool,
  title: PropTypes.string.isRequired,
  value: PropTypes.number,
}

export { Panel, PanelItem }
