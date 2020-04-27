import React, { Component, Fragment } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Table from '../../components/TournamentTable'
import {
  loadTournamentsSummary,
  changePage,
} from '../../actions/tournaments'
import { tournamentTableSelector } from '../../selectors/tournaments'

class TournamentTable extends Component {
  componentDidMount() {
    if (!this.props.loaded) {
      this.props.loadTournamentsSummary()
    }
  }

  handlePageChange = pageNumber => {
    this.props.changePage(pageNumber)
  }

  render() {
    return (
      <Fragment>
        <h2>Tournament database</h2>
        <Table
          items={this.props.entries}
          currentPage={this.props.currentPage}
          pageCount={this.props.pageCount}
          onPageChanged={this.handlePageChange}
          type="tournament"
        />
      </Fragment>
    )
  }
}

TournamentTable.propTypes = {
  changePage: PropTypes.func.isRequired,
  currentPage: PropTypes.number.isRequired,
  entries: PropTypes.array.isRequired,
  loaded: PropTypes.bool.isRequired,
  loadTournamentsSummary: PropTypes.func.isRequired,
  pageCount: PropTypes.number.isRequired,
}

export default connect(state => tournamentTableSelector(state), {
  loadTournamentsSummary,
  changePage,
})(TournamentTable)
