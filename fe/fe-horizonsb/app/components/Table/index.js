import React from 'react'
import PropTypes from 'prop-types'
import TableFooter from './TableFooter'
import { TableContainer, EmptyRow } from './styled'

const Table = ({
  items,
  pageCount,
  currentPage,
  onPageChanged,
  renderRow,
  renderHeader,
}) => (
  <TableContainer>
    {renderHeader()}
    {items.length > 0 ? (
      items.map(item => renderRow({ key: item.id || item.name, ...item }))
    ) : (
      <EmptyRow>No items matched your search criteria</EmptyRow>
    )}
    <TableFooter
      pageCount={pageCount}
      currentPage={currentPage}
      onPageChanged={onPageChanged}
    />
  </TableContainer>
)

Table.propTypes = {
  currentPage: PropTypes.number.isRequired,
  items: PropTypes.array.isRequired,
  onPageChanged: PropTypes.func.isRequired,
  pageCount: PropTypes.number.isRequired,
  renderHeader: PropTypes.func.isRequired,
  renderRow: PropTypes.func.isRequired,
}

export default Table
