import { takeLatest, call, put } from 'redux-saga/effects'
import handleError from './errorHandler'
import apiClient from '../services/apiService'
import {
  GET_LIVE_SUMMARY,
  gotLiveSummary,
  getLiveSummaryError,
} from '../actions/summary'
import { normalizeRetrievedLiveData } from '../normalize/summary'

function* onLoadLiveSummary(action) {
  try {
    const responseLiveTotal = yield call(apiClient.getLiveTotalSummary)
    const responseLiveInPriority = yield call(apiClient.getLiveInPriorityTotalSummary)
    const data = normalizeRetrievedLiveData(responseLiveTotal.data, responseLiveInPriority.data)

    yield put(gotLiveSummary(data))
  } catch (error) {
    yield handleError(error, action, getLiveSummaryError)
  }
}

export default function* watchSaga() {
  yield takeLatest(GET_LIVE_SUMMARY.PENDING, onLoadLiveSummary)
}
