import constants from '../utils/constants'
import paginationHelper from '../utils/paginationHelper'

const eventTableSelector = ({ events }) => ({
  entries: paginationHelper({
    itemsPerPage: constants.eventTablePageSize,
    currentPage: events.options.currentPage,
  })(events.entries),
  loaded: events.loaded,
  currentPage: events.options.currentPage,
  pageCount: events.options.pageCount,
})

export { eventTableSelector }
