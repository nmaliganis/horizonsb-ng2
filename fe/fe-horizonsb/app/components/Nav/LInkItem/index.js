import React from 'react'
import PropTypes from 'prop-types'
import { NavLink } from 'react-router-dom'

const LinkItem = ({ href, label }) => (
  <li>
    <NavLink to={href} activeClassName="active">
      {label}
    </NavLink>
  </li>
)

LinkItem.propTypes = {
  href: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
}

export default LinkItem
