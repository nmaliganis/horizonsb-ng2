import { takeLatest, call, put } from 'redux-saga/effects'
import { dateFormatIntl } from '../utils/helpers'
import apiClient from '../services/apiService'
import {
  GET_TOURNAMENT_SUMMARY,
  gotTournamentSummary,
  getTournamentSummaryError,
} from '../actions/summary'
import {
  FILTER_SUMMARY,
  filteredTournamentSummary,
  filterTournamentSummaryError,
} from '../actions/filter'
import { normalizeRetrievedData } from '../normalize/summary'
import handleError from './errorHandler'

function* onLoadTournamentSummary(action) {
  try {
    const responseTournamentTotals = yield call(apiClient.getTournamentTotalSummary)
    const responseTournamentPriority = yield call(apiClient.getTournamentPrioritySummary)
    const data = normalizeRetrievedData(responseTournamentTotals.data, responseTournamentPriority.data, 0)
    yield put(gotTournamentSummary(data))
  } catch (error) {
    yield handleError(error, action, getTournamentSummaryError)
  }
}

function* onFilterTournamentSummary(action) {
  try {
    const requestParams = {}
    if (action.payload.from && action.payload.to) {
      requestParams.from = dateFormatIntl(action.payload.from)
      requestParams.to = dateFormatIntl(action.payload.to)
    }
    const response = yield call(apiClient.filterUsersSummary, requestParams)
    yield put(filteredTournamentSummary(response.data, action.payload))
  } catch (error) {
    yield handleError(error, action, filterTournamentSummaryError)
  }
}

export default function* watchSaga() {
  yield takeLatest(GET_TOURNAMENT_SUMMARY.PENDING, onLoadTournamentSummary)
  yield takeLatest(FILTER_SUMMARY, onFilterTournamentSummary)
}
