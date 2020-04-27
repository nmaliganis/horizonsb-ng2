import { takeLatest, call, put } from 'redux-saga/effects'
import { normalizePutData } from '../normalize/tournaments'
import handleError from './errorHandler'
import {
  UPDATE_TOURNAMENT,
  LOAD_TOURNAMENT,
  LOAD_TOURNAMENTS_SUMMARY,
  updateTournamentSuccess,
  updateTournamentError,
  loadTournamentSuccess,
  loadTournamentError,
  tournamentsSummaryLoaded,
  tournamentsSummaryLoadError,
} from '../actions/tournaments'
import apiService from '../services/apiService'
import { history } from '../containers/App'

function* onUpdateTournament(action) {
  try {
    const data = normalizePutData(action.payload)
    const response = yield call(apiService.updateTournament, data)
    yield put(updateTournamentSuccess(response.data))
    history.push('/tournaments/list')
  } catch (error) {
    yield handleError(error, action, updateTournamentError)
  }
}

function* onLoadTournament(action) {
  try {
    const response = yield call(apiService.getTournamentById, action.payload)
    yield put(loadTournamentSuccess(response.data))
  } catch (error) {
    yield handleError(error, action, loadTournamentError)
  }
}


function* onLoadTournamentsSummary(action) {
  try {
    const response = yield call(apiService.getTournamentsSummary)
    yield put(tournamentsSummaryLoaded(response.data))
  } catch (error) {
    yield handleError(error, action, tournamentsSummaryLoadError)
  }
}

export default function* watchSaga() {
  yield takeLatest(UPDATE_TOURNAMENT.PENDING, onUpdateTournament)
  yield takeLatest(LOAD_TOURNAMENT.PENDING, onLoadTournament)
  yield takeLatest(LOAD_TOURNAMENTS_SUMMARY.PENDING, onLoadTournamentsSummary)
}
