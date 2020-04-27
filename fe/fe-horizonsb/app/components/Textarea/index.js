import React, { Fragment } from 'react'
import styled from 'styled-components'
import PropTypes from 'prop-types'
import { ElementContainer, Label, Error } from '../Form/styled'

const Container = styled(ElementContainer)`
  height: 114px;
`

const CharacterLimit = styled.span`
  display: block;
  color: #969696;
  font-size: 12px;
  margin-top: 5px;
`

const Textarea = ({ error, label, ...textareaProps }) => (
  <Fragment>
    {label && (
      <Fragment>
        <Label>{label}</Label>
        {textareaProps.maxLength !== null &&
          <CharacterLimit>{textareaProps.maxLength - textareaProps.value.length} of {textareaProps.maxLength} characters left</CharacterLimit>
        }
      </Fragment>
    )}
    <Container>
      <textarea {...textareaProps} />
    </Container>
    {error && (
      <Error>{error}</Error>
    )}
  </Fragment>
)

Textarea.defaultProps = {
  error: null,
  label: null,
}

Textarea.propTypes = {
  error: PropTypes.string,
  label: PropTypes.string,
}

export default Textarea
