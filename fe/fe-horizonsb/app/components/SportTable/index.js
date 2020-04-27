import React from 'react'
import PropTypes from 'prop-types'
import TableRow from './TableRow'
import TableHeader from './TableHeader'
import TableFooter from './TableFooter'
import { TableContainer, EmptyRow } from './styled'

const SportTable = ({
  sports,
  pageCount,
  currentPage,
  onPageChanged,
  sortColumn,
  sortDirection,
  onSortChanged,
}) => (
  <TableContainer>
    <TableHeader
      sortColumn={sortColumn}
      sortDirection={sortDirection}
      onSortChanged={onSortChanged}
    />
    {sports.length > 0 ? (
      sports.map(sport => (
        <TableRow
          key={sport.id}
          {...sport}
        />
      ))
    ) : (
      <EmptyRow>No sports matched your search criteria</EmptyRow>
    )}
    <TableFooter
      pageCount={pageCount}
      currentPage={currentPage}
      onPageChanged={onPageChanged}
    />
  </TableContainer>
)

SportTable.propTypes = {
  currentPage: PropTypes.number.isRequired,
  onPageChanged: PropTypes.func.isRequired,
  onSortChanged: PropTypes.func.isRequired,
  pageCount: PropTypes.number.isRequired,
  sortColumn: PropTypes.string.isRequired,
  sortDirection: PropTypes.string.isRequired,
  sports: PropTypes.array.isRequired,
}

export default SportTable
