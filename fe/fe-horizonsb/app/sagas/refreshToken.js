import { take, call, put, actionChannel } from 'redux-saga/effects'
import clientStorage from '../services/clientStorage'
import apiService from '../services/apiService'
import constants from '../utils/constants'
import { REFRESH_TOKEN, signOut } from '../actions/auth'

function* onRefreshToken(actionToRetry) {
  try {
    const lastRefreshAt = clientStorage.getLastRefreshTimestamp()

    if (lastRefreshAt) {
      if (
        (new Date().getTime() - lastRefreshAt) / 1000 <
        constants.tokenRefreshIntervalSec
      ) {
        yield put(actionToRetry.payload)
      } else {
        const refreshToken = clientStorage.removeTokens()
        const response = yield call(apiService.refreshToken, refreshToken)
        clientStorage.setTokens(
          response.data.accessToken,
          response.data.refreshToken
        )
        yield put(actionToRetry.payload)
      }
    } else {
      yield put(signOut())
    }
  } catch (error) {
    yield put(signOut())
  }
}

export default function* watchSaga() {
  const refreshActionQueue = yield actionChannel(REFRESH_TOKEN)
  while (true) {
    const action = yield take(refreshActionQueue)
    yield call(onRefreshToken, action)
  }
}
