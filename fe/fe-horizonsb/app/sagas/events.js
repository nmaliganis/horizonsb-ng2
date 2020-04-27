import { takeLatest, call, put } from 'redux-saga/effects'
import { normalizePutData, normalizeGetData } from '../normalize/events'
import {
  LOAD_EVENTS,
  LOAD_EVENT,
  UPDATE_EVENT,
  eventsLoaded,
  eventsLoadError,
  updateEventSuccess,
  updateEventError,
  loadEventSuccess,
  loadEventError,
} from '../actions/events'
import { history } from '../containers/App'
import apiService from '../services/apiService'
import handleError from './errorHandler'

function* onUpdateEvent(action) {
  try {
    const data = normalizePutData(action.payload)
    const response = yield call(apiService.updateEvent, data)
    yield put(updateEventSuccess(response.data))
    history.push('/events/list')
  } catch (error) {
    yield handleError(error, action, updateEventError)
  }
}

function* onLoadEvents(action) {
  try {
    const data = normalizeGetData()
    const eventsResponse = yield call(apiService.getEvents, data)
    yield put(eventsLoaded(eventsResponse.data))
  } catch (error) {
    yield handleError(error, action, eventsLoadError)
  }
}

function* onLoadEvent(action) {
  try {
    const response = yield call(apiService.getEvent, action.payload)
    yield put(loadEventSuccess(response.data))
  } catch (error) {
    yield handleError(error, action, loadEventError)
  }
}


export default function* watchSaga() {
  yield takeLatest(UPDATE_EVENT.PENDING, onUpdateEvent)
  yield takeLatest(LOAD_EVENTS.PENDING, onLoadEvents)
  yield takeLatest(LOAD_EVENT.PENDING, onLoadEvent)
}
