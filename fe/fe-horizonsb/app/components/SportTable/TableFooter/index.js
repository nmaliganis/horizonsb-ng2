import React, { Component } from 'react'
import PropTypes from 'prop-types'
import Pagination from './Pagination'
import { FooterContainer, PrevArrow, NextArrow } from './styled'

class TableFooter extends Component {
  prevPage = () => {
    if (this.canGetPrev()) {
      this.props.onPageChanged(this.props.currentPage - 1)
    }
  }

  nextPage = () => {
    if (this.canGetNext()) {
      this.props.onPageChanged(this.props.currentPage + 1)
    }
  }

  canGetPrev = () => this.props.currentPage > 0
  canGetNext = () => this.props.currentPage < this.props.pageCount - 1

  render() {
    return (
      <FooterContainer>
        <PrevArrow active={this.canGetPrev()} onClick={this.prevPage}>
          ◄
        </PrevArrow>
        <Pagination {...this.props} />
        <NextArrow active={this.canGetNext()} onClick={this.nextPage}>
          ►
        </NextArrow>
      </FooterContainer>
    )
  }
}

TableFooter.propTypes = {
  currentPage: PropTypes.number.isRequired,
  onPageChanged: PropTypes.func.isRequired,
  pageCount: PropTypes.number.isRequired,
}

export default TableFooter
