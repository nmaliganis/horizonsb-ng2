import { takeLatest, call, put } from 'redux-saga/effects'
import clientStorage from '../services/clientStorage'
import apiService from '../services/apiService'
import {
  SIGN_IN,
  SIGN_OUT,
  signedIn,
  signInError,
  signedOut,
} from '../actions/auth'

function* onSignIn(action) {
  try {
    const response = yield call(apiService.authenticate, action.payload)
    clientStorage.setTokens(
      response.data.accessToken,
      response.data.refreshToken
    )
    yield put(signedIn(response.data))
  } catch (error) {
    yield put(signInError(error.response.data.message))
  }
}

function* onSignOut() {
  clientStorage.removeTokens()
  yield put(signedOut())
}

function* onError(action) {
  if (
    action.payload === 'jwt malformed'
    || action.payload === 'The user was not authorized.'
  ) {
    yield onSignOut()
  }
}

export default function* watchSaga() {
  yield takeLatest(SIGN_IN.PENDING, onSignIn)
  yield takeLatest(SIGN_OUT.PENDING, onSignOut)
  yield takeLatest('*', onError)
}
