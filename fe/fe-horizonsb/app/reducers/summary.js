import {
  GET_TOURNAMENT_SUMMARY,
  GET_SPORT_SUMMARY,
  GET_EVENT_SUMMARY,
  GET_MARKET_SUMMARY,
  GET_LIVE_SUMMARY,
} from '../actions/summary'
import { FILTER_USERS_SUMMARY, FILTER_SPORT_SUMMARY } from '../actions/filter'
import { SIGN_OUT } from '../actions/auth'

const defaultState = {
  sport: {
    data: {},
    loaded: false,
  },
  tournament: {
    data: {},
    loaded: false,
  },
  event: {
    data: {},
    loaded: false,
  },
  market: {
    data: {},
    loaded: false,
  },
  live: {
    data: {},
    loaded: false,
  },
  currentRange: {
    from: undefined,
    to: undefined,
  },
}

const summaryReducer = (state = defaultState, action) => {
  switch (action.type) {
    case GET_TOURNAMENT_SUMMARY.SUCCESS:
      return {
        ...state,
        tournament: {
          ...state.tournament,
          data: action.payload.data,
          loaded: true,
        },
      }
    case GET_SPORT_SUMMARY.SUCCESS:
      return {
        ...state,
        sport: {
          ...state.sport,
          data: action.payload.data,
          loaded: true,
        },
      }
    case FILTER_USERS_SUMMARY.SUCCESS:
      return {
        ...state,
        currentRange: action.payload.range,
        tournament: {
          ...state.tournament,
          data: {
            ...state.tournament.data,
            totalCount: action.payload.data.count,
          },
        },
      }
    case FILTER_SPORT_SUMMARY.SUCCESS:
      return {
        ...state,
        currentRange: action.payload.range,
        sport: {
          ...state.sport,
          data: {
            ...state.sport.data,
            totalCount: action.payload.data.sum,
          },
        },
      }
    case GET_EVENT_SUMMARY.SUCCESS:
      return {
        ...state,
        event: {
          ...state.event,
          data: action.payload.data,
          loaded: true,
        },
      }
    case GET_MARKET_SUMMARY.SUCCESS:
      return {
        ...state,
        market: {
          ...state.market,
          data: action.payload.data,
          loaded: true,
        },
      }
      case GET_LIVE_SUMMARY.SUCCESS:
        return {
          ...state,
          live: {
            ...state.live,
            data: action.payload.data,
            loaded: true,
          },
        }
      case SIGN_OUT.SUCCESS:
      return defaultState
    default:
      return state
  }
}

export default summaryReducer
