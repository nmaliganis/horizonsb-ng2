import constants from '../utils/constants'
import {
  CLEAR_LOADED_SPORT,
  LOAD_SPORTS,
  LOAD_SPORT,
  UPDATE_SPORT,
} from '../actions/sports'
import { SIGN_OUT } from '../actions/auth'
import { mapIfId } from '../utils/ramdaRedux'

const defaultState = {
  entries: [],
  options: {
    total: 0,
    currentPage: 0,
    pageCount: 0,
    filter: {
      property: null,
      query: {
        label: null,
        value: null,
      },
    },
    sort: {
      column: 'name',
      direction: constants.sortDesc,
    },
  },
  isLoading: false,
  loaded: false,
  isLoadingEntry: false,
  isUpdating: false,
}

const sportsReducer = (state = defaultState, action) => {
  const { type, payload } = action

  switch (type) {
    case CLEAR_LOADED_SPORT:
      return {
        ...state,
        entry: null,
      }
    case LOAD_SPORT.PENDING:
      return {
        ...state,
        isLoadingEntry: true,
      }
    case LOAD_SPORT.SUCCESS:
      return {
        ...state,
        isLoadingEntry: false,
        entry: payload,
      }
    case LOAD_SPORTS.PENDING:
      return {
        ...state,
        isLoading: true,
      }
    case UPDATE_SPORT.PENDING:
      return {
        ...state,
        isUpdating: true,
      }
    case UPDATE_SPORT.ERROR:
      return {
        ...state,
        isUpdating: false,
      }
    case UPDATE_SPORT.SUCCESS:
      return {
        ...state,
        isUpdating: false,
        entries: mapIfId(payload.id)(item => ({
          ...item,
          ...payload,
        }))(state.entries),
      }
    case LOAD_SPORTS.SUCCESS:
      return {
        ...state,
        entries: payload.sports.items,
        options: {
          ...state.options,
          total: payload.sports.totalCount,
          pageCount: Math.ceil(
            payload.sports.totalCount / constants.sportTablePageSize,
          ),
          filter: payload.filter,
          sort: payload.sort,
        },
        isLoading: false,
        loaded: true,
      }
    case SIGN_OUT.SUCCESS:
      return defaultState
    default:
      return state
  }
}

export default sportsReducer
