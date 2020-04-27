import { takeLatest, call, put } from 'redux-saga/effects'
import handleError from './errorHandler'
import apiClient from '../services/apiService'
import {
  GET_MARKET_SUMMARY,
  gotMarketSummary,
  getMarketSummaryError,
} from '../actions/summary'
import { normalizeRetrievedMarketData } from '../normalize/summary'

function* onLoadMarketSummary(action) {
  try {
    const responseMarketTotal = yield call(apiClient.getMarketTotalSummary)
    const responseOddTotal = yield call(apiClient.getOddTotalSummary)
    const data = normalizeRetrievedMarketData(responseMarketTotal.data, responseOddTotal.data)
    yield put(gotMarketSummary(data))
  } catch (error) {
    yield handleError(error, action, getMarketSummaryError)
  }
}

export default function* watchSaga() {
  yield takeLatest(GET_MARKET_SUMMARY.PENDING, onLoadMarketSummary)
}
