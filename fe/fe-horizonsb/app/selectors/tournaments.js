import { compose, ascend, prop, sort, toUpper, head,} from 'ramda'
import constants from '../utils/constants'
import paginationHelper from '../utils/paginationHelper'

  const tournamentTableSelector = ({ tournaments }) => ({
  entries: compose(
    paginationHelper({
      itemsPerPage: constants.tournamentsTablePageSize,
      currentPage: tournaments.options.currentPage,
    }),
    sort(
      ascend(
        compose(
          toUpper,
          head,
          prop('name'),
        ),
      ),
    ),
  )(tournaments.entries),
  loaded: tournaments.loaded,
  currentPage: tournaments.options.currentPage,
  pageCount: tournaments.options.pageCount,
})

export { tournamentTableSelector }
