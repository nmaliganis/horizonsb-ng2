import React, { Component, Fragment } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Table from '../../components/SportTable'
import {
  loadSports,
  sortSports,
} from '../../actions/sports'
import { sportTableSelector } from '../../selectors/sports'

class SportTable extends Component {
  componentDidMount() {
    if (!this.props.loaded) {
      this.props.loadSports()
    }
  }

  handlePageChange = page => {
    this.props.loadSports(page)
  }

  handleSortChange = (column, direction) => {
    this.props.sortSports({ column, direction })
  }

  render() {
    return (
      <Fragment>
        <h2>Sport database</h2>
        <Table
          sports={this.props.entries}
          currentPage={this.props.currentPage}
          pageCount={this.props.pageCount}
          onPageChanged={this.handlePageChange}
          sortColumn={this.props.sortColumn}
          sortDirection={this.props.sortDirection}
          onSortChanged={this.handleSortChange}
        />
      </Fragment>
    )
  }
}

SportTable.propTypes = {
  currentPage: PropTypes.number.isRequired,
  entries: PropTypes.array.isRequired,
  loaded: PropTypes.bool.isRequired,
  loadSports: PropTypes.func.isRequired,
  pageCount: PropTypes.number.isRequired,
  sortColumn: PropTypes.string.isRequired,
  sortDirection: PropTypes.string.isRequired,
  sortSports: PropTypes.func.isRequired,
}

export default connect(state => sportTableSelector(state), {
  loadSports: loadSports,
  sortSports: sortSports,
})(SportTable)
