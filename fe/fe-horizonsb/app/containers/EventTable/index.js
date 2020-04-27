import React, { Component, Fragment } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Table from '../../components/EventTable'
import {
  loadEvents,
  changePage,
} from '../../actions/events'
import { eventTableSelector } from '../../selectors/events'

class EventTable extends Component {
  componentDidMount() {
    if (!this.props.loaded) {
      this.props.loadEvents()
    }
  }

  handlePageChange = pageNumber => {
    this.props.changePage(pageNumber)
  }

  render() {
    return (
      <Fragment>
        <h2>Event database</h2>
        <Table
          items={this.props.entries}
          currentPage={this.props.currentPage}
          pageCount={this.props.pageCount}
          onPageChanged={this.handlePageChange}
          type="event"
        />
      </Fragment>
    )
  }
}

EventTable.propTypes = {
  changePage: PropTypes.func.isRequired,
  currentPage: PropTypes.number.isRequired,
  entries: PropTypes.array.isRequired,
  loaded: PropTypes.bool.isRequired,
  loadEvents: PropTypes.func.isRequired,
  pageCount: PropTypes.number.isRequired,
}

export default connect(state => eventTableSelector(state), {
  loadEvents,
  changePage,
})(EventTable)
