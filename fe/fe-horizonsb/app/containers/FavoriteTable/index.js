import React, { Component, Fragment } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Table from '../../components/FavoriteTable'
import {
  loadFavorites,
  changePage,
} from '../../actions/favoriteevents'
import { favoriteTableSelector } from '../../selectors/favoriteevents'

class FavoriteTable extends Component {
  componentDidMount() {
    if (!this.props.loaded) {
      this.props.loadFavorites()
    }
  }

  handlePageChange = pageNumber => {
    this.props.changePage(pageNumber)
  }

  render() {
    return (
      <Fragment>
        <h2>Favorite database</h2>
        <Table
          items={this.props.entries}
          currentPage={this.props.currentPage}
          pageCount={this.props.pageCount}
          onPageChanged={this.handlePageChange}
          type="favorite"
        />
      </Fragment>
    )
  }
}

FavoriteTable.propTypes = {
  changePage: PropTypes.func.isRequired,
  currentPage: PropTypes.number.isRequired,
  entries: PropTypes.array.isRequired,
  loaded: PropTypes.bool.isRequired,
  loadFavorites: PropTypes.func.isRequired,
  pageCount: PropTypes.number.isRequired,
}

export default connect(state => favoriteTableSelector(state), {
  loadFavorites,
  changePage,
})(FavoriteTable)
