import { createActionSet } from '../utils/actionHelper'

const SIGN_IN = createActionSet('signin')
const SIGN_OUT = createActionSet('signout')
const REFRESH_TOKEN = 'refreshToken'

const signIn = token => ({ type: SIGN_IN.PENDING, payload: token })
const signedIn = user => ({ type: SIGN_IN.SUCCESS, payload: user })
const signInError = message => ({ type: SIGN_IN.ERROR, payload: message })
const signOut = () => ({ type: SIGN_OUT.PENDING })
const signedOut = () => ({ type: SIGN_OUT.SUCCESS })
const refreshToken = actionToRetry => ({
  type: REFRESH_TOKEN,
  payload: actionToRetry,
})

export {
  SIGN_IN,
  SIGN_OUT,
  REFRESH_TOKEN,
  signIn,
  signedIn,
  signInError,
  signOut,
  signedOut,
  refreshToken,
}
