import React, { Fragment } from 'react'
import styled from 'styled-components'
import PropTypes from 'prop-types'
import { ElementContainer, Label, Error } from '../Form/styled'

const CharacterLimit = styled.span`
  display: block;
  color: #969696;
  font-size: 12px;
  margin-top: 5px;
`

const Input = ({ error, label, ...inputProps }) => (
  <Fragment>
    {label && (
      <Label>{label}</Label>
    )}
    {Boolean(inputProps.maxLength) &&
      <CharacterLimit>{inputProps.maxLength - inputProps.value.length} of {inputProps.maxLength} characters left</CharacterLimit>
    }
    <ElementContainer isHidden={inputProps.type === 'hidden'}>
      <input {...inputProps} />
    </ElementContainer>
    {error && (
      <Error>{error}</Error>
    )}
  </Fragment>
)

Input.defaultProps = {
  error: null,
  label: null,
}

Input.propTypes = {
  error: PropTypes.string,
  label: PropTypes.string,
}

export default Input
