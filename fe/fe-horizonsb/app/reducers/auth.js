import { SIGN_IN, SIGN_OUT } from '../actions/auth'

const defaultState = {
  //authenticated: false,
  authenticated: true,
  authError: null,
  authenticating: false,
}

const authReducer = (state = defaultState, action) => {
  switch (action.type) {
    case SIGN_IN.PENDING:
      //return { authenticated: false, authError: null, authenticating: true }
      return { authenticated: true, authError: null, authenticating: true }
    case SIGN_IN.SUCCESS:
      //return { authenticated: true, authError: null, authenticating: false }
      return { authenticated: true, authError: null, authenticating: false }
    case SIGN_IN.ERROR:
      return {
        //authenticated: false,
        authenticated: true,
        authError: action.payload,
        authenticating: false,
      }
    case SIGN_OUT.SUCCESS:
      return defaultState
    default:
      return state
  }
}

export default authReducer
