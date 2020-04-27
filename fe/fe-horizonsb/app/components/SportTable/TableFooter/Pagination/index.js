import React from 'react'
import PropTypes from 'prop-types'
import config from '../../../../utils/constants'
import { range } from '../../../../utils/helpers'
import { PaginationContainer, PageItem } from './styled'

const Pagination = ({ currentPage, pageCount, onPageChanged }) => {
  const from = Math.max(
    0,
    currentPage - Math.floor(config.userTablePaginationLength / 2)
  )
  const to = Math.min(
    pageCount,
    currentPage + config.userTablePaginationLength - (currentPage - from)
  )

  return (
    <PaginationContainer>
      {range(from, to).map(page => (
        <PageItem
          key={page}
          onClick={() => onPageChanged(page)}
          active={page === currentPage}
        >
          {page + 1}
        </PageItem>
      ))}
    </PaginationContainer>
  )
}

Pagination.propTypes = {
  currentPage: PropTypes.number.isRequired,
  onPageChanged: PropTypes.func.isRequired,
  pageCount: PropTypes.number.isRequired,
}

export default Pagination
