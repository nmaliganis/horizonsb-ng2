import { compose, ascend, prop, sort, head,} from 'ramda'
import constants from '../utils/constants'
import paginationHelper from '../utils/paginationHelper'

const favoriteTableSelector = ({ favorites }) => ({
  entries: compose(
    paginationHelper({
      itemsPerPage: constants.favoritesTablePageSize,
      currentPage: favorites.options.currentPage,
    }),
    sort(
      ascend(
        compose(
          head,
          prop('name'),
        ),
      ),
    ),
  )(favorites.entries),
  loaded: favorites.loaded,
  currentPage: favorites.options.currentPage,
  pageCount: favorites.options.pageCount,
})

export { favoriteTableSelector }
