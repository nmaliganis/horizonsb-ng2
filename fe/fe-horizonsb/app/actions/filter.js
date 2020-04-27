import { createActionSet } from 'utils/actionHelper'

const FILTER_USERS_SUMMARY = createActionSet('filter-tournament-summary')
const FILTER_SPORT_SUMMARY = createActionSet('filter-sport-summary')
const FILTER_SUMMARY = 'filter-summary'

const filterSummary = payload => ({
  type: FILTER_SUMMARY,
  payload,
})

const filteredLiveSummary = (data, range) => ({
  type: FILTER_USERS_SUMMARY.SUCCESS,
  payload: {
    data,
    range,
  },
})

const filterLiveSummaryError = message => ({
  type: FILTER_USERS_SUMMARY.ERROR,
  payload: message,
})

const filteredTournamentSummary = (data, range) => ({
  type: FILTER_USERS_SUMMARY.SUCCESS,
  payload: {
    data,
    range,
  },
})

const filterTournamentSummaryError = message => ({
  type: FILTER_USERS_SUMMARY.ERROR,
  payload: message,
})

const filteredSportSummary = (data, range) => ({
  type: FILTER_SPORT_SUMMARY.SUCCESS,
  payload: {
    data,
    range,
  },
})

const filterSportSummaryError = message => ({
  type: FILTER_SPORT_SUMMARY.ERROR,
  payload: message,
})

export {
  FILTER_SUMMARY,
  FILTER_USERS_SUMMARY,
  FILTER_SPORT_SUMMARY,
  filterSummary,
  filteredTournamentSummary,
  filterTournamentSummaryError,
  filteredLiveSummary,
  filterLiveSummaryError,
  filteredSportSummary,
  filterSportSummaryError,
}
