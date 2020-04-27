import { put, call } from 'redux-saga/effects'
import constants from '../utils/constants'
import wait from '../utils/wait'
import { clearError } from '../actions/error'
import { refreshToken } from '../actions/auth'

export default function* handleError(error, action, actionCreator) {
  if (error.code === 'ECONNABORTED') {
    const data = error
    const message = data.message || data
    yield put(actionCreator(message))
  } else if (error.response && error.response.status === constants.tokenExpiredHttpCode) {
    yield put(refreshToken(action))
  } else {
    const data = error.response && error.response.data
    const message = (data && data.message) || data || error.message
    yield put(actionCreator(message))
    yield call(wait)
    yield put(clearError())
  }
}
