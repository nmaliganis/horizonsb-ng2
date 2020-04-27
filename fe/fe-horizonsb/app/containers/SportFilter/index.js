import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Column from '../../components/Column'
import Container from '../../components/Container'
import SearchBox from '../../components/SearchBox'
import SearchSelect from '../../components/Select'
import SearchLabel from '../../components/SearchLabel'
import { sportFilterSelector } from '../../selectors/sports'
import { filterSports, resetSportsFilter } from '../../actions/sports'
import { SearchButton, Panel } from './styled'
import { filterOptions, searchColumnDefs } from './searchColumns'

const emptyState = {
  option: null,
  query: {
    label: '',
    value: '',
  },
}

class SportFilter extends Component {
  constructor(props) {
    super(props)
    this.state = emptyState
  }

  handleOptionChange = option => {
    this.setState({ ...this.state, option })
  }

  handleSearchValueChange = event => {
    const value = this.state.option
      ? searchColumnDefs[this.state.option.value].formatter(event.target.value)
      : event.target.value

    this.setState({
      ...this.state,
      query: {
        label: event.target.value,
        value,
      },
    })
  }

  handleFilterChange = () => {
    this.canApplyFilter() &&
      this.props.filterSports({
        property: this.state.option,
        query: this.state.query,
      })
  }

  canApplyFilter = () => this.state.option && this.state.query.value.length > 0

  handleFilterReset = () => {
    this.setState(emptyState)
    this.props.resetSportsFilter()
  }

  render() {
    const { option } = this.state
    const { filterProperty, filterQuery } = this.props

    return (
      <Panel>
        <Container>
          <Column width={25}>
            <SearchSelect
              options={filterOptions}
              value={option && option.value}
              onChange={this.handleOptionChange}
              placeholder="Please select"
            />
          </Column>
          <Column width={25}>
            <SearchBox
              value={this.state.query.label}
              placeholder={
                option ? searchColumnDefs[option.value].placeholder : 'Search'
              }
              onChange={this.handleSearchValueChange}
            />
          </Column>
          <Column width={25}>
            <SearchLabel
              onReset={this.handleFilterReset}
              query={filterQuery.label}
              property={filterProperty}
            />
          </Column>
          <Column width={25}>
            <SearchButton
              onClick={this.handleFilterChange}
              active={this.canApplyFilter()}
            >
              Search
            </SearchButton>
          </Column>
        </Container>
      </Panel>
    )
  }
}

SportFilter.defaultProps = {
  filterProperty: undefined,
  filterQuery: undefined,
}

SportFilter.propTypes = {
  filterProperty: PropTypes.object,
  filterQuery: PropTypes.object,
  filterSports: PropTypes.func.isRequired,
  resetSportsFilter: PropTypes.func.isRequired,
}

export default connect(state => sportFilterSelector(state), {
  filterSports: filterSports,
  resetSportsFilter: resetSportsFilter,
})(SportFilter)
