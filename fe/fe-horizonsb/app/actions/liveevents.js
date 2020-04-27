import { createActionSet } from '../utils/actionHelper'

const LOAD_LIVES = createActionSet('lives')
const LOAD_LIVE = createActionSet('live')
const CLEAR_LOADED_LIVE = 'live/CLEAR_LOADED_LIVE'
const UPDATE_LIVE = createActionSet('updateLive')

const CHANGE_PAGE = 'live/CHANGE_PAGE'

const clearLoadedLive = () => ({
  type: CLEAR_LOADED_LIVE,
})

const loadLive = (id) => ({
  type: LOAD_LIVE.PENDING,
  payload: {
    id,
  }
})

const loadLiveSuccess = payload => ({
  type: LOAD_LIVE.SUCCESS,
  payload,
})

const loadLiveError = message => ({
  type: LOAD_LIVE.ERROR,
  payload: message,
})

const updateLive = payload => ({
  type: UPDATE_LIVE.PENDING,
  payload,
})

const updateLiveSuccess = payload => ({
  type: UPDATE_LIVE.SUCCESS,
  payload,
})

const updateLiveError = message => ({
  type: UPDATE_LIVE.ERROR,
  payload: message,
})

const loadLives = (page = 0) => ({
  type: LOAD_LIVES.PENDING,
  payload: {
    page,
  },
})

const livesLoaded = lives => ({
  type: LOAD_LIVES.SUCCESS,
  payload: {
    live : lives,
  },
})


const filterLives = filter => ({
  type: LOAD_LIVES.PENDING,
  payload: {
    filter,
    page: 0,
  },
})

const sortLives = live => ({
  type: LOAD_LIVES.PENDING,
  payload: {
    sort,
  },
})

const resetLivesFilter = () => ({
  type: LOAD_LIVES.PENDING,
  payload: {
    filter: {
      query: {
        label: '',
        value: '',
      },
    },
    page: 0,
  },
})

const LivesLoaded = (lives, { filter, sort }) => ({
  type: LOAD_LIVES.SUCCESS,
  payload: {
    lives,
    filter,
    sort,
  },
})

const liveLoadError = message => ({ type: LOAD_LIVES.ERROR, payload: message })

const changePage = pageNumber => ({
  type: CHANGE_PAGE,
  payload: {
    pageNumber,
  },
})

export {
  LOAD_LIVES,
  loadLives,

  CLEAR_LOADED_LIVE,
  clearLoadedLive,

  LOAD_LIVE,
  loadLive,
  loadLiveSuccess,
  loadLiveError,

  UPDATE_LIVE,
  updateLive,
  updateLiveSuccess,
  updateLiveError,

  filterLives,
  resetLivesFilter,
  sortLives,
  livesLoaded,
  liveLoadError,

  CHANGE_PAGE,
  changePage,
}
