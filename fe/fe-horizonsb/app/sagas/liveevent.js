import { takeLatest, call, put } from 'redux-saga/effects'
import handleError from './errorHandler'
import { normalizePutData, normalizeGetData } from '../normalize/liveevents'
import {
  UPDATE_LIVE,
  LOAD_LIVE,
  LOAD_LIVES,
  loadLiveSuccess,
  livesLoaded,
  loadLiveError,
  updateLiveSuccess,
  updateLiveError,
} from '../actions/liveevents'
import apiService from '../services/apiService'
import { history } from '../containers/App'


function* onUpdateLive(action) {
  try {
    const data = normalizePutData(action.payload)
    const response = yield call(apiService.updateLiveEvent, data)
    yield put(updateLiveSuccess(response.data))
    history.push('/lives/list')
  } catch (error) {
    yield handleError(error, action, updateLiveError)
  }
}

function* onLoadLive(action) {
  try {
    const response = yield call(apiService.getLive, action.payload)
    yield put(loadLiveSuccess(response.data))
  } catch (error) {
    yield handleError(error, action, loadLiveError)
  }
}

function* onLoadLivesSummary(action) {
  try {
    const data = normalizeGetData()
    const response = yield call(apiService.getLives, data)
    yield put(livesLoaded(response.data))
  } catch (error) {
    yield handleError(error, action, loadLiveError)
  }
}

export default function* watchSaga() {
  yield takeLatest(UPDATE_LIVE.PENDING, onUpdateLive)
  yield takeLatest(LOAD_LIVE.PENDING, onLoadLive)
  yield takeLatest(LOAD_LIVES.PENDING, onLoadLivesSummary)
}
