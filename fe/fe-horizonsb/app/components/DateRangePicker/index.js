import React, { Component } from 'react'
import PropTypes from 'prop-types'
import DatePicker from "../DatePicker"
import { DatePickerWrapper, DatePickerContainer } from './styled'

class DateRangePicker extends Component {
  constructor(props) {
    super(props)
    this.handleFromChange = this.handleFromChange.bind(this)
    this.handleToChange = this.handleToChange.bind(this)
  }

  handleFromChange(from) {
    if (from) {
      from = new Date(from.setHours(0, 0, 0, 0))
    }
    this.props.onRangeChanged({ from, to: this.props.to })
    document.getElementById('to').click()
  }

  handleToChange(to) {
    if (to) {
      to = new Date(to.setHours(0, 0, 0, 0))
    }
    this.props.onRangeChanged({ from: this.props.from, to })
  }

  render() {
    const { from, to } = this.props

    return (
      <DatePickerContainer>
        <DatePickerWrapper>
          <DatePicker
            selected={from}
            selectsStart
            placeholderText="MM/DD/YYYY"
            onChange={this.handleFromChange}
            startDate={from}
            endDate={to}
          />
        </DatePickerWrapper>
        <DatePickerWrapper>
          <DatePicker
            selected={to}
            selectsEnd
            placeholderText="MM/DD/YYYY"
            onChange={this.handleToChange}
            startDate={from}
            endDate={to}
            id="to"
          />
        </DatePickerWrapper>
      </DatePickerContainer>
    )
  }
}

DateRangePicker.defaultProps = {
  from: undefined,
  to: undefined,
}

DateRangePicker.propTypes = {
  from: PropTypes.instanceOf(Date),
  onRangeChanged: PropTypes.func.isRequired,
  to: PropTypes.instanceOf(Date),
}

export default DateRangePicker
