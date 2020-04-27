import { takeLatest, call, put } from 'redux-saga/effects'
import {
  FILTER_SUMMARY,
  filteredSportSummary,
  filterSportSummaryError,
} from '../actions/filter'
import { dateFormatIntl } from '../utils/helpers'
import apiClient from '../services/apiService'
import {
  GET_SPORT_SUMMARY,
  gotSportSummary,
  getSportSummaryError,
} from '../actions/summary'
import handleError from './errorHandler'
import { normalizeRetrievedData } from '../normalize/summary'

function* onLoadSportSummary(action) {
  try {
    const responseSportTotals = yield call(apiClient.getSportTotalSummary)
    const responseSportPriority = yield call(apiClient.getSportPrioritySummary)
    const data = normalizeRetrievedData(responseSportTotals.data, responseSportPriority.data , 0)
    yield put(gotSportSummary(data))
  } catch (error) {
    yield handleError(error, action, getSportSummaryError)
  }
}

function* onFilterSportSummary(action) {
  try {
    const requestParams = {}
    if (action.payload.from && action.payload.to) {
      requestParams.from = dateFormatIntl(action.payload.from)
      requestParams.to = dateFormatIntl(action.payload.to)
    }
    const response = yield call(apiClient.filterSportSummary, requestParams)
    yield put(filteredSportSummary(response.data, action.payload))
  } catch (error) {
    yield handleError(error, action, filterSportSummaryError)
  }
}

export default function* watchSaga() {
  yield takeLatest(GET_SPORT_SUMMARY.PENDING, onLoadSportSummary)
  yield takeLatest(FILTER_SUMMARY, onFilterSportSummary)
}
