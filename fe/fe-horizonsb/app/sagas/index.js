import { all, fork } from 'redux-saga/effects'
import auth from './auth'
import refreshToken from './refreshToken'
import eventSummary from './eventSummary'
import marketSummary from './marketSummary'
import tournamentSummary from './tournamentSummary'
import liveSummary from './liveSummary'
import sportSummary from './sportSummary'
import sports from './sports'
import contest from './contest'
import favorites from './favoriteevent'
import lives from './liveevent'
import tournaments from './tournaments'
import events from './events'

export default function* root() {
  yield all([
    fork(auth),
    fork(refreshToken),
    fork(eventSummary),
    fork(marketSummary),
    fork(sportSummary),
    fork(sports),
    fork(contest),
    fork(favorites),
    fork(lives),
    fork(liveSummary),
    fork(tournaments),
    fork(tournamentSummary),
    fork(events),
  ])
}
