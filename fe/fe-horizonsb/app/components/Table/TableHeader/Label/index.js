import React from 'react'
import PropTypes from 'prop-types'
import { Container } from './styled'

const Label = ({ displayName}) => (
  <Container>
    <span>{displayName}</span>
  </Container>
)

Label.propTypes = {
  displayName: PropTypes.string.isRequired,
}

export default Label
