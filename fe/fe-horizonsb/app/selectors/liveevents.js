import { compose, ascend, prop, sort, head,} from 'ramda'
import constants from '../utils/constants'
import paginationHelper from '../utils/paginationHelper'

const liveTableSelector = ({ lives }) => ({
  entries: compose(
    paginationHelper({
      itemsPerPage: constants.livesTablePageSize,
      currentPage: lives.options.currentPage,
    }),
    sort(
      ascend(
        compose(
          head,
          prop('livePriority'),
        ),
      ),
    ),
  )(lives.entries),
  loaded: lives.loaded,
  currentPage: lives.options.currentPage,
  pageCount: lives.options.pageCount,
})

export { liveTableSelector }
