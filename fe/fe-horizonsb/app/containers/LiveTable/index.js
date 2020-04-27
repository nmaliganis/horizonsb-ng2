import React, { Component, Fragment } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Table from '../../components/LiveTable'
import {
  loadLives,
  changePage,
} from '../../actions/liveevents'
import { liveTableSelector } from '../../selectors/liveevents'

class LiveTable extends Component {
  componentDidMount() {
    if (!this.props.loaded) {
      this.props.loadLives()
    }
  }

  handlePageChange = pageNumber => {
    this.props.changePage(pageNumber)
  }

  render() {
    return (
      <Fragment>
        <h2>Live database</h2>
        <Table
          items={this.props.entries}
          currentPage={this.props.currentPage}
          pageCount={this.props.pageCount}
          onPageChanged={this.handlePageChange}
          type="live"
        />
      </Fragment>
    )
  }
}

LiveTable.propTypes = {
  changePage: PropTypes.func.isRequired,
  currentPage: PropTypes.number.isRequired,
  entries: PropTypes.array.isRequired,
  loaded: PropTypes.bool.isRequired,
  loadLives: PropTypes.func.isRequired,
  pageCount: PropTypes.number.isRequired,
}

export default connect(state => liveTableSelector(state), {
  loadLives,
  changePage,
})(LiveTable)
