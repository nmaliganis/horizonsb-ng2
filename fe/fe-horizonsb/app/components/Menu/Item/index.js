import React from 'react'
import PropTypes from 'prop-types'
import { MenuItem } from './styled'

const Item = ({ isActive, label, to }) => (
  <MenuItem active={isActive ? 'true' : 'false'} to={to} activeClassName="active">
    {label}
  </MenuItem>
)

Item.propTypes = {
  isActive: PropTypes.bool.isRequired,
  label: PropTypes.string.isRequired,
  to: PropTypes.string.isRequired,
}

export default Item
