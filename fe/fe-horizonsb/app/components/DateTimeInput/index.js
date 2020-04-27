import React, { Fragment } from 'react'
import PropTypes from 'prop-types'
import { Label, Error } from '../Form/styled'
import DatePicker from "../DatePicker"

const DateTimeInput = ({ error, label, ...datePickerProps }) => (
  <Fragment>
    {label && (
      <Label>{label}</Label>
    )}
    <DatePicker {...datePickerProps} />
    {error && (
      <Error>{error}</Error>
    )}
  </Fragment>
)

DateTimeInput.defaultProps = {
  error: null,
  label: null,
}

DateTimeInput.propTypes = {
  error: PropTypes.string,
  label: PropTypes.string,
}

export default DateTimeInput
