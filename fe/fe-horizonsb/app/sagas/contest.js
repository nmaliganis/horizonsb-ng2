import { takeLatest, call, put } from 'redux-saga/effects'
import {
  CONTEST_SUMMARY,
  LATEST_SUMMARY,
  postContestError,
  postContestSuccess,
  getLatestSummaryError,
  getLatestSummarySuccess,
} from '../actions/contest'
import apiService from '../services/apiService'
import handleError from './errorHandler'

function* postContest(action) {
  try {
    const response = yield call(apiService.postContest, action.payload)
    yield put(postContestSuccess(response.data))
  } catch (error) {
    yield handleError(error, action, postContestError)
  }
}

function* getLatest(action) {
  try {
    const response = yield call(apiService.getLatestSummary, action.payload)
    yield put(getLatestSummarySuccess(response.data))
  } catch (error) {
    yield handleError(error, action, getLatestSummaryError)
  }
}

export default function* watchSaga() {
  yield takeLatest(CONTEST_SUMMARY.PENDING, postContest)
  yield takeLatest(LATEST_SUMMARY.PENDING, getLatest)
}
