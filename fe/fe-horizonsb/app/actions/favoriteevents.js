import { createActionSet } from '../utils/actionHelper'

const LOAD_FAVORITES = createActionSet('favorites')
const LOAD_FAVORITE = createActionSet('favorite')
const CLEAR_LOADED_FAVORITE = 'favorite/CLEAR_LOADED_FAVORITE'
const UPDATE_FAVORITE = createActionSet('updateFavorite')

const CHANGE_PAGE = 'favorite/CHANGE_PAGE'

const clearLoadedFavorite = () => ({
  type: CLEAR_LOADED_FAVORITE,
})

const loadFavorite = (id) => ({
  type: LOAD_FAVORITE.PENDING,
  payload: {
    id,
  }
})

const loadFavoriteSuccess = payload => ({
  type: LOAD_FAVORITE.SUCCESS,
  payload,
})

const loadFavoriteError = message => ({
  type: LOAD_FAVORITE.ERROR,
  payload: message,
})

const updateFavorite = payload => ({
  type: UPDATE_FAVORITE.PENDING,
  payload,
})

const updateFavoriteSuccess = payload => ({
  type: UPDATE_FAVORITE.SUCCESS,
  payload,
})

const updateFavoriteError = message => ({
  type: UPDATE_FAVORITE.ERROR,
  payload: message,
})

const loadFavorites = (page = 0) => ({
  type: LOAD_FAVORITES.PENDING,
  payload: {
    page,
  },
})

const favoritesLoaded = favorites => ({
  type: LOAD_FAVORITES.SUCCESS,
  payload: {
    favorites : favorites,
  },
})


const filterFavorites = filter => ({
  type: LOAD_FAVORITES.PENDING,
  payload: {
    filter,
    page: 0,
  },
})

const sortFavorites = favorite => ({
  type: LOAD_FAVORITES.PENDING,
  payload: {
    sort,
  },
})

const resetFavoritesFilter = () => ({
  type: LOAD_FAVORITES.PENDING,
  payload: {
    filter: {
      query: {
        label: '',
        value: '',
      },
    },
    page: 0,
  },
})

const FavoritesLoaded = (favorites, { filter, sort }) => ({
  type: LOAD_FAVORITES.SUCCESS,
  payload: {
    favorites,
    filter,
    sort,
  },
})

const favoriteLoadError = message => ({ type: LOAD_FAVORITES.ERROR, payload: message })

const changePage = pageNumber => ({
  type: CHANGE_PAGE,
  payload: {
    pageNumber,
  },
})

export {
  LOAD_FAVORITES,
  loadFavorites,

  CLEAR_LOADED_FAVORITE,
  clearLoadedFavorite,

  LOAD_FAVORITE,
  loadFavorite,
  loadFavoriteSuccess,
  loadFavoriteError,

  UPDATE_FAVORITE,
  updateFavorite,
  updateFavoriteSuccess,
  updateFavoriteError,

  filterFavorites,
  resetFavoritesFilter,
  sortFavorites,
  favoritesLoaded,
  favoriteLoadError,

  CHANGE_PAGE,
  changePage,
}
