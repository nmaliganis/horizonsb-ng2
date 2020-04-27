import { takeLatest, call, put, select } from 'redux-saga/effects'
import constants from '../utils/constants'
import {
  LOAD_SPORTS,
  LOAD_SPORT,
  UPDATE_SPORT,
  sportsLoaded,
  sportLoadError,
  loadSportSuccess,
  loadSportError,
  updateSportSuccess,
  updateSportError,
} from '../actions/sports'
import handleError from './errorHandler'
import apiService from '../services/apiService'
import { normalizePutData } from '../normalize/tournaments'
import { history } from '../containers/App'

function* onLoadSport(action) {
  try {
    const response = yield call(apiService.getSportById, action.payload)
    yield put(loadSportSuccess(response.data))
  } catch (error) {
    yield handleError(error, action, loadSportError)
  }
}

function* onUpdateSport(action) {
  try {
    const data = normalizePutData(action.payload)
    const response = yield call(apiService.updateSport, data)
    yield put(updateSportSuccess(response.data))
    history.push('/sports')
  } catch (error) {
    yield handleError(error, action, updateSportError())
  }
}


function* onLoadSports(action) {
  try {
    const options = yield select(state => state.sports.options)
    if (action.payload.filter) {
      options.filter = action.payload.filter
    }
    if (action.payload.sort) {
      options.sort = action.payload.sort
    }
    if (Number.isInteger(action.payload.page)) {
      options.currentPage = action.payload.page
    }

    const requestParams = {
      offset: options.currentPage * constants.sportTablePageSize,
      limit: constants.sportTablePageSize,
      orderColumn: options.sort.column,
      orderDirection: options.sort.direction,
    }

    if (options.filter.property) {
      requestParams.searchColumn = options.filter.property.value
      requestParams.searchQuery = options.filter.query.value
    }
    const response = yield call(apiService.getSports, requestParams)
    yield put(sportsLoaded(response.data, options))
  } catch (error) {
    yield handleError(error, action, sportLoadError)
  }
}

export default function* watchSaga() {
  yield takeLatest(UPDATE_SPORT.PENDING, onUpdateSport)
  yield takeLatest(LOAD_SPORTS.PENDING, onLoadSports)
  yield takeLatest(LOAD_SPORT.PENDING, onLoadSport)

}
