import { mapIfId } from '../utils/ramdaRedux'
import {
  LOAD_EVENTS,
  LOAD_EVENT,
  CHANGE_PAGE,
  UPDATE_EVENT,
  CLEAR_LOADED_EVENT,
} from '../actions/events'
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
  isCreating: false,
  isUpdating: false,
}

const eventsReducer = (state = defaultState, action) => {
  const { type, payload } = action

  switch (type) {
    case CLEAR_LOADED_EVENT:
      return {
        ...state,
        entry: null,
      }
    case LOAD_EVENT.PENDING:
      return {
        ...state,
        isLoadingEntry: true,
      }
    case LOAD_EVENT.SUCCESS:
      return {
        ...state,
        isLoadingEntry: false,
        entry: payload,
      }
    case UPDATE_EVENT.PENDING:
      return {
        ...state,
        isUpdating: true,
      }
    case UPDATE_EVENT.ERROR:
      return {
        ...state,
        isUpdating: false,
      }
    case UPDATE_EVENT.SUCCESS:
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
    case LOAD_EVENTS.PENDING:
      return {
        ...state,
        isLoading: true,
      }
    case LOAD_EVENTS.SUCCESS:
      return {
        ...state,
        entries: payload.events,
        options: {
          ...state.options,
          total: payload.events.length,
          pageCount: Math.ceil(
            payload.events.length / constants.eventTablePageSize,
          ),
        },
        isLoading: false,
        loaded: true,
      }
    default:
      return state
  }
}

export default eventsReducer
