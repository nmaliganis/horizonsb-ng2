import { combineReducers } from 'redux'
import auth from './auth'
import tournaments from './tournaments'
import lives from './liveevents'
import favorites from './favoriteevents'
import summary from './summary'
import sports from './sports'
import error from './error'
import events from './events'
import contest from './contest'

const rootReducer = combineReducers({
  auth,
  tournaments,
  lives,
  favorites,
  summary,
  sports,
  error,
  events,
  contest,
})

export default rootReducer
