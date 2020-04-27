import { takeLatest, call, put } from 'redux-saga/effects'
import handleError from './errorHandler'
import apiClient from '../services/apiService'
import {
  GET_EVENT_SUMMARY,
  gotEventSummary,
  getEventSummaryError,
} from '../actions/summary'

import { normalizeRetrievedData } from '../normalize/summary'

function* onLoadEventSummary(action) {
  try {
    const responseEventTotals = yield call(apiClient.getEventTotalSummary)
    const responseEventPriority = yield call(apiClient.getEventPrioritySummary)
    const responseEventFavorite = yield call(apiClient.getEventFavoriteSummary)
    const data = normalizeRetrievedData(responseEventTotals.data, responseEventPriority.data, responseEventFavorite.data)
    yield put(gotEventSummary(data))
  } catch (error) {
    yield handleError(error, action, getEventSummaryError)
  }
}

export default function* watchSaga() {
  yield takeLatest(GET_EVENT_SUMMARY.PENDING, onLoadEventSummary)
}
