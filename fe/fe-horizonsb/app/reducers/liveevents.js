import { mapIfId } from '../utils/ramdaRedux'
import {
  LOAD_LIVES,
  CHANGE_PAGE,
  UPDATE_LIVE,
  LOAD_LIVE,
  CLEAR_LOADED_LIVE,
} from '../actions/liveevents'
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

const livesReducer = (state = defaultState, action) => {
  const { type, payload } = action

  switch (type) {
    case CLEAR_LOADED_LIVE:
      return {
        ...state,
        entry: null,
      }
    case LOAD_LIVE.PENDING:
      return {
        ...state,
        isLoadingEntry: true,
      }
    case LOAD_LIVE.SUCCESS:
      return {
        ...state,
        isLoadingEntry: false,
        entry: payload,
      }
    case UPDATE_LIVE.PENDING:
      return {
        ...state,
        isUpdating: true,
      }
    case UPDATE_LIVE.ERROR:
      return {
        ...state,
        isUpdating: false,
      }
    case UPDATE_LIVE.SUCCESS:
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
    case LOAD_LIVES.PENDING:
      return {
        ...state,
        isLoading: true,
      }
    case LOAD_LIVES.SUCCESS:
      return {
        ...state,
        entries: payload.live,
        options: {
          ...state.options,
          total: payload.live.length,
          pageCount: Math.ceil(
            payload.live.length / constants.livesTablePageSize,
          ),
        },
        isLoading: false,
        loaded: false,
      }
    default:
      return state
  }
}

export default livesReducer
