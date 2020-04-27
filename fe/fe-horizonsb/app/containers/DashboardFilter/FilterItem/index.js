import React from 'react'
import PropTypes from 'prop-types'

import { ListItem } from './styled'

const FilterItem = ({ isActive, label, onClick }) => (
  <ListItem active={isActive} onClick={onClick}>
    {label}
  </ListItem>
)

FilterItem.propTypes = {
  isActive: PropTypes.bool.isRequired,
  label: PropTypes.string.isRequired,
  onClick: PropTypes.func.isRequired,
}

export default FilterItem
