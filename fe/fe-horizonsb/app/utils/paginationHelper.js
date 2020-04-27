import { slice } from 'ramda'

const paginationHelper = ({ itemsPerPage, currentPage }) => items => {
  const sliceFrom = itemsPerPage * currentPage
  const sliceTo = sliceFrom + itemsPerPage
  return slice(sliceFrom, sliceTo, items)
}

export default paginationHelper
