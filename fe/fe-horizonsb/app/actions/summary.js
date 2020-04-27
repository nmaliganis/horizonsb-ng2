import { createActionSet } from '../utils/actionHelper'

const GET_SPORT_SUMMARY = createActionSet('sport-summary')
const GET_TOURNAMENT_SUMMARY = createActionSet('tournament-summary')
const GET_LIVE_SUMMARY = createActionSet('live-summary')
const GET_EVENT_SUMMARY = createActionSet('event-summary')
const GET_MARKET_SUMMARY = createActionSet('market-summary')

const getSportSummary = () => ({ type: GET_SPORT_SUMMARY.PENDING })

const gotSportSummary = data => ({
  type: GET_SPORT_SUMMARY.SUCCESS,
  payload: {
    data,
  },
})

const getSportSummaryError = message => ({
  type: GET_SPORT_SUMMARY.ERROR,
  payload: message,
})

const getTournamentSummary = () => ({ type: GET_TOURNAMENT_SUMMARY.PENDING })

const gotTournamentSummary = data => ({
  type: GET_TOURNAMENT_SUMMARY.SUCCESS,
  payload: {
    data,
  },
})

const getTournamentSummaryError = message => ({
  type: GET_TOURNAMENT_SUMMARY.ERROR,
  payload: message,
})

const getLiveSummary = () => ({ type: GET_LIVE_SUMMARY.PENDING })

const gotLiveSummary = data => ({
  type: GET_LIVE_SUMMARY.SUCCESS,
  payload: {
    data,
  },
})

const getLiveSummaryError = message => ({
  type: GET_LIVE_SUMMARY.ERROR,
  payload: message,
})

const getEventSummary = () => ({ type: GET_EVENT_SUMMARY.PENDING })

const gotEventSummary = data => ({
  type: GET_EVENT_SUMMARY.SUCCESS,
  payload: {
    data,
  },
})

const getEventSummaryError = message => ({
  type: GET_EVENT_SUMMARY.ERROR,
  payload: message,
})

const getMarketSummary = () => ({ type: GET_MARKET_SUMMARY.PENDING })

const gotMarketSummary = data => ({
  type: GET_MARKET_SUMMARY.SUCCESS,
  payload: {
    data,
  },
})

const getMarketSummaryError = message => ({
  type: GET_MARKET_SUMMARY.ERROR,
  payload: message,
})


export {
  GET_SPORT_SUMMARY,
  getSportSummary,
  gotSportSummary,
  getSportSummaryError,

  GET_TOURNAMENT_SUMMARY,
  getTournamentSummary,
  gotTournamentSummary,
  getTournamentSummaryError,

  GET_LIVE_SUMMARY,
  getLiveSummary,
  gotLiveSummary,
  getLiveSummaryError,


  GET_EVENT_SUMMARY,
  getEventSummary,
  gotEventSummary,
  getEventSummaryError,

  GET_MARKET_SUMMARY,
  getMarketSummary,
  gotMarketSummary,
  getMarketSummaryError,
}
