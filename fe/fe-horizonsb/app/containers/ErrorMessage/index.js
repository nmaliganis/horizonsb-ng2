import React from 'react'
import { connect } from 'react-redux'
import { Container } from './styled'

const ErrorMessage = ({ message }) =>
  message && (
    <Container>
      <p>{message}</p>
    </Container>
  )

export default connect(state => state.error)(ErrorMessage)
