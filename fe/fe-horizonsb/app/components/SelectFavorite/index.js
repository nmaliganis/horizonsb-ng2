import React, { Fragment } from 'react'
import PropTypes from 'prop-types'
import { Checkbox, CheckboxLabel } from './styled'

const SelectFavorite = ({ checkboxValue, toggleCheckbox}) => (
  <Fragment>
    <div>
      <Checkbox onChange={toggleCheckbox} checked={checkboxValue} id="favoriteBox" type="checkbox" />
      <CheckboxLabel htmlFor="favoriteBox">Is Favorite?</CheckboxLabel>
    </div>
  </Fragment>
)

SelectFavorite.defaultProps = {
  error: null,
  checkboxValue : false
}

SelectFavorite.propTypes = {
  checkboxValue: PropTypes.bool.isRequired,
  error: PropTypes.string,
  toggleCheckbox: PropTypes.func.isRequired,
}

export default (SelectFavorite)
