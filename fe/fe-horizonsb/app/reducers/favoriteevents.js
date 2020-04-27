import { mapIfId } from '../utils/ramdaRedux'
import {
  LOAD_FAVORITES,
  CHANGE_PAGE,
  UPDATE_FAVORITE,
  LOAD_FAVORITE,
  CLEAR_LOADED_FAVORITE,
} from '../actions/favoriteevents'
import constants from '../utils/constants'

const defaultState = {
  // Detail/Update
  entry: null,
  // List
  entries: [],
  options: {
    total: 0,
    currentPage: 0,
    pageCount: 0,
  },
  isLoading: false,
  loaded: false,
  isLoadingEntry: false,
  isUpdating: false,
}

const favoritesReducer = (state = defaultState, action) => {
  const { type, payload } = action

  switch (type) {
    case CLEAR_LOADED_FAVORITE:
      return {
        ...state,
        entry: null,
      }
    case LOAD_FAVORITE.PENDING:
      return {
        ...state,
        isLoadingEntry: true,
      }
    case LOAD_FAVORITE.SUCCESS:
      return {
        ...state,
        isLoadingEntry: false,
        entry: payload,
      }
    case UPDATE_FAVORITE.PENDING:
      return {
        ...state,
        isUpdating: true,
      }
    case UPDATE_FAVORITE.ERROR:
      return {
        ...state,
        isUpdating: false,
      }
    case UPDATE_FAVORITE.SUCCESS:
      return {
        ...state,
        isUpdating: false,
        entries: mapIfId(payload.id)(item => ({
          ...item,
          ...payload,
        }))(state.entries),
      }
    case CHANGE_PAGE:
      return {
        ...state,
        options: {
          ...state.options,
          currentPage: payload.pageNumber,
        }
      }
    case LOAD_FAVORITES.PENDING:
      return {
        ...state,
        isLoading: true,
      }
    case LOAD_FAVORITES.SUCCESS:
      return {
        ...state,
        entries: payload.favorites,
        options: {
          ...state.options,
          total: payload.favorites.length,
          pageCount: Math.ceil(
            payload.favorites.length / constants.favoritesTablePageSize,
          ),
        },
        isLoading: false,
        loaded: false,
      }
    default:
      return state
  }
}

export default favoritesReducer
