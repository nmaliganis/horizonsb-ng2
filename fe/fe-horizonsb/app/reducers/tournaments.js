import { mapIfId } from '../utils/ramdaRedux'
import {
  LOAD_TOURNAMENTS,
  CHANGE_PAGE,
  UPDATE_TOURNAMENT,
  LOAD_TOURNAMENT,
  CLEAR_LOADED_TOURNAMENT,
  LOAD_TOURNAMENTS_SUMMARY,
} from '../actions/tournaments'
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

const tournamentsReducer = (state = defaultState, action) => {
  const { type, payload } = action

  switch (type) {
    case CLEAR_LOADED_TOURNAMENT:
      return {
        ...state,
        entry: null,
      }
    case LOAD_TOURNAMENT.PENDING:
      return {
        ...state,
        isLoadingEntry: true,
      }
    case LOAD_TOURNAMENT.SUCCESS:
      return {
        ...state,
        isLoadingEntry: false,
        entry: payload,
      }
    case UPDATE_TOURNAMENT.PENDING:
      return {
        ...state,
        isUpdating: true,
      }
    case UPDATE_TOURNAMENT.ERROR:
      return {
        ...state,
        isUpdating: false,
      }
    case UPDATE_TOURNAMENT.SUCCESS:
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
    case LOAD_TOURNAMENTS.PENDING:
      return {
        ...state,
        isLoading: true,
      }
    case LOAD_TOURNAMENTS.SUCCESS:
      return {
        ...state,
        entries: payload.tournament,
        options: {
          ...state.options,
          total: payload.tournament.length,
          pageCount: Math.ceil(
            payload.tournament.length / constants.tournamentsTablePageSize,
          ),
        },
        isLoading: false,
        loaded: false,
      }
    case LOAD_TOURNAMENTS_SUMMARY.PENDING:
      return {
        ...state,
        isLoading: true,
      }
    case LOAD_TOURNAMENTS_SUMMARY.SUCCESS:
      return {
        ...state,
        entries: payload.tournament,
        options: {
          ...state.options,
          total: payload.tournament.length,
          pageCount: Math.ceil(
            payload.tournament.length / constants.tournamentsTablePageSize,
          ),
        },
        isLoading: false,
        loaded: true,
      }
    default:
      return state
  }
}

export default tournamentsReducer
