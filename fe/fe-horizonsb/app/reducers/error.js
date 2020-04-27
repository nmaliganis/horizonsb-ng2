import { FILTER_USERS_SUMMARY, FILTER_SPORT_SUMMARY } from '../actions/filter'
import { SIGN_OUT } from '../actions/auth'
import {
  LOAD_SPORTS,
} from '../actions/sports'
import { LOAD_TOURNAMENTS, LOAD_TOURNAMENT, UPDATE_TOURNAMENT, LOAD_TOURNAMENTS_SUMMARY } from '../actions/tournaments'
import { LOAD_EVENTS } from '../actions/events'
import { CLEAR_ERROR } from '../actions/error'
import {
  GET_TOURNAMENT_SUMMARY,
  GET_SPORT_SUMMARY,
  GET_EVENT_SUMMARY,
} from '../actions/summary'

const defaultState = {
  message: null,
}

const errorReducer = (state = defaultState, action) => {
  switch (action.type) {
    case LOAD_EVENTS.ERROR:
    case LOAD_TOURNAMENT.ERROR:
    case UPDATE_TOURNAMENT.ERROR:
    case LOAD_SPORTS.ERROR:
    case LOAD_TOURNAMENTS.ERROR:
    case GET_TOURNAMENT_SUMMARY.ERROR:
    case GET_SPORT_SUMMARY.ERROR:
    case GET_EVENT_SUMMARY.ERROR:
    case FILTER_USERS_SUMMARY.ERROR:
    case FILTER_SPORT_SUMMARY.ERROR:
    case LOAD_TOURNAMENTS_SUMMARY.ERROR:
      return { message: action.payload }
    case SIGN_OUT.SUCCESS:
      return defaultState
    case CLEAR_ERROR:
      return {
        ...state,
        message: null
      }
    default:
      return state
  }
}

export default errorReducer
