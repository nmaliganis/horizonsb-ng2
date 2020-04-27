import { takeLatest, call, put } from 'redux-saga/effects'
import handleError from './errorHandler'
import { normalizePutData, normalizeGetData } from '../normalize/liveevents'
import {
  UPDATE_FAVORITE,
  LOAD_FAVORITE,
  LOAD_FAVORITES,
  loadFavoriteSuccess,
  favoritesLoaded,
  loadFavoriteError,
  updateFavoriteSuccess,
  updateFavoriteError,
} from '../actions/favoriteevents'
import apiService from '../services/apiService'
import { history } from '../containers/App'

function* onUpdateFavorite(action) {
  try {
    const data = normalizePutData(action.payload)
    const response = yield call(apiService.updateFavorite, data)
    yield put(updateFavoriteSuccess(response.data))
    history.push('/favorites/list')
  } catch (error) {
    yield handleError(error, action, updateFavoriteError)
  }
}

function* onLoadFavorite(action) {
  try {
    const response = yield call(apiService.getFavorite, action.payload)
    yield put(loadFavoriteSuccess(response.data))
  } catch (error) {
    yield handleError(error, action, loadFavoriteError())
  }
}

function* onLoadFavoritesSummary(action) {
  try {
    const data = normalizeGetData()
    const response = yield call(apiService.getFavorites, data)
    yield put(favoritesLoaded(response.data))
  } catch (error) {
    yield handleError(error, action, loadFavoriteError)
  }
}

export default function* watchSaga() {
  yield takeLatest(UPDATE_FAVORITE.PENDING, onUpdateFavorite)
  yield takeLatest(LOAD_FAVORITE.PENDING, onLoadFavorite)
  yield takeLatest(LOAD_FAVORITES.PENDING, onLoadFavoritesSummary)
}
