import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Panel, FilterList } from './styled'
import FilterItem from './FilterItem'
import Column from '../../components/Column'
import Container from '../../components/Container'
import DateRangePicker from '../../components/DateRangePicker'
import { getWeekRange, getMonthRange, areRangesEqual } from '../../utils/helpers'
import { filterSummary } from '../../actions/filter'
import { filterSelector } from '../../selectors/summary'

const fixedFilters = [
  { label: 'Overview', range: { from: undefined, to: undefined } },
  { label: 'Today', range: getMonthRange() },
  { label: 'Yesterday', range: getWeekRange() },
]

class DashboardFilter extends Component {
  handleFilterChange = range => {
    this.props.filterSummary(range)
  }

  render() {
    return (
      <Panel>
        <Container>
          <Column width={50}>
            <FilterList>
              {fixedFilters.map(filter => (
                <FilterItem
                  label={filter.label}
                  key={filter.label}
                  isActive={areRangesEqual(
                    filter.range,
                    this.props.currentRange
                  )}
                  onClick={() => this.handleFilterChange(filter.range)}
                />
              ))}
            </FilterList>
          </Column>
          <Column width={50}>
            <DateRangePicker
              onRangeChanged={this.handleFilterChange}
              from={this.props.currentRange.from}
              to={this.props.currentRange.to}
            />
          </Column>
        </Container>
      </Panel>
    )
  }
}

DashboardFilter.propTypes = {
  currentRange: PropTypes.object.isRequired,
  filterSummary: PropTypes.func.isRequired,
}

export default connect(state => filterSelector(state), { filterSummary })(
  DashboardFilter
)
