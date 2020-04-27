import { createActionSet } from '../utils/actionHelper'

const LOAD_TOURNAMENTS_SUMMARY = createActionSet('tournamentsSummary')

const LOAD_TOURNAMENTS = createActionSet('tournament')
const CHANGE_PAGE = 'tournament/CHANGE_PAGE'

const LOAD_TOURNAMENT = createActionSet('tournament')
const CLEAR_LOADED_TOURNAMENT = 'tournament/CLEAR_LOADED_TOURNAMENT'

const UPDATE_TOURNAMENT = createActionSet('updateTournament')

const clearLoadedTournament = () => ({
  type: CLEAR_LOADED_TOURNAMENT,
})

const loadTournament = (id) => ({
  type: LOAD_TOURNAMENT.PENDING,
  payload: {
    id,
  }
})

const loadTournamentSuccess = payload => ({
  type: LOAD_TOURNAMENT.SUCCESS,
  payload,
})

const loadTournamentError = message => ({
  type: LOAD_TOURNAMENT.ERROR,
  payload: message,
})

const updateTournament = payload => ({
  type: UPDATE_TOURNAMENT.PENDING,
  payload,
})

const updateTournamentSuccess = payload => ({
  type: UPDATE_TOURNAMENT.SUCCESS,
  payload,
})

const updateTournamentError = message => ({
  type: UPDATE_TOURNAMENT.ERROR,
  payload: message,
})

const tournamentsLoaded = tournaments => ({
    type: LOAD_TOURNAMENTS.SUCCESS,
    payload: {
      tournament: tournaments,
    },
  })

const tournamentsLoadError = message => ({
    type: LOAD_TOURNAMENTS.ERROR,
    payload: message,
  })

const loadTournamentsSummary = () => ({
  type: LOAD_TOURNAMENTS_SUMMARY.PENDING,
})

const tournamentsSummaryLoaded = tournaments => ({
    type: LOAD_TOURNAMENTS_SUMMARY.SUCCESS,
    payload: {
      tournament: tournaments,
    },
  })

const tournamentsSummaryLoadError = message => ({
    type: LOAD_TOURNAMENTS_SUMMARY.ERROR,
    payload: message,
  })

const changePage = pageNumber => ({
      type: CHANGE_PAGE,
      payload: {
        pageNumber,
      },
    })

export {
  LOAD_TOURNAMENTS_SUMMARY,
  loadTournamentsSummary,
  tournamentsSummaryLoaded,
  tournamentsSummaryLoadError,

  CLEAR_LOADED_TOURNAMENT,
  clearLoadedTournament,

  LOAD_TOURNAMENT,
  loadTournament,
  loadTournamentSuccess,
  loadTournamentError,

  UPDATE_TOURNAMENT,
  updateTournament,
  updateTournamentSuccess,
  updateTournamentError,

  LOAD_TOURNAMENTS,
  tournamentsLoaded,
  tournamentsLoadError,

  CHANGE_PAGE,
  changePage,
}
