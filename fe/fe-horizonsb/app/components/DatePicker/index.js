import React, { PureComponent } from 'react'
import ReactDatePicker from 'react-datepicker'
import 'react-datepicker/dist/react-datepicker.css'
import { Container } from './styled'

// We'll need to use ref property, so it has to be a class-based component
// ---
// eslint-disable-next-line react/prefer-stateless-function
export default class DatePicker extends PureComponent {
  render () {
    return (
      <Container>
        <ReactDatePicker autoComplete="off" {...this.props} />
      </Container>
    )
  }
}
