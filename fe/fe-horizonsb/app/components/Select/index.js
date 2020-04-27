import React, { Fragment } from 'react'
import PropTypes from 'prop-types'
import { Label, Error } from '../Form/styled'
import { StyledSelect } from './styled'

const Select = ({ error, label, ...selectProps }) => (
  <Fragment>
    {label && (
      <Label>{label}</Label>
    )}
    <StyledSelect {...selectProps} />
    {error && (
      <Error>{error}</Error>
    )}
  </Fragment>
)

Select.defaultProps = {
  error: null,
  label: null,
}

Select.propTypes = {
  error: PropTypes.string,
  label: PropTypes.string,
}

export default Select
