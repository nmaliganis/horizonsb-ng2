import React, { Component } from 'react'
import PropTypes from 'prop-types'

import constants from '../../../../utils/constants'
import { SortNoneIcon, SortAscIcon, SortDescIcon } from '../../../../assets/icons'
import { SortContainer } from './styled'

class SortLabel extends Component {
  handleSortChange = () => {
    if (this.props.sortable) {
      let newDirection = this.props.sortDirection
      if (this.props.sortColumn === this.props.name) {
        newDirection =
          this.props.sortDirection === constants.sortDesc
            ? constants.sortAsc
            : constants.sortDesc
      }
      this.props.onSortChanged(this.props.name, newDirection)
    }
  }

  render() {
    let sortIcon = <SortNoneIcon />
    if (this.props.sortColumn === this.props.name) {
      sortIcon =
        this.props.sortDirection === constants.sortAsc ? (
          <SortDescIcon />
        ) : (
          <SortAscIcon />
        )
    }

    return (
      <SortContainer
        onClick={this.handleSortChange}
        sortable={this.props.sortable}
      >
        <span>{this.props.displayName}</span>
        {this.props.sortable && sortIcon}
      </SortContainer>
    )
  }
}

SortLabel.defaultProps = {
  sortable: true,
}

SortLabel.propTypes = {
  displayName: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  onSortChanged: PropTypes.func.isRequired,
  sortable: PropTypes.bool,
  sortColumn: PropTypes.string.isRequired,
  sortDirection: PropTypes.string.isRequired,
}

export default SortLabel
