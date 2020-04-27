import { createActionSet } from '../utils/actionHelper'

const LOAD_SPORTS = createActionSet('sports')
const LOAD_SPORT = createActionSet('sport')
const CLEAR_LOADED_SPORT= 'sport/CLEAR_LOADED_SPORT'
const UPDATE_SPORT = createActionSet('updateSport')


const clearLoadedSport = () => ({
  type: CLEAR_LOADED_SPORT,
})

const loadSport = (id) => ({
  type: LOAD_SPORT.PENDING,
  payload: {
    id,
  }
})

const loadSportSuccess = payload => ({
  type: LOAD_SPORT.SUCCESS,
  payload,
})

const loadSportError = message => ({
  type: LOAD_SPORT.ERROR,
  payload: message,
})

const updateSport = payload => ({
  type: UPDATE_SPORT.PENDING,
  payload,
})

const updateSportSuccess = payload => ({
  type: UPDATE_SPORT.SUCCESS,
  payload,
})

const updateSportError = message => ({
  type: UPDATE_SPORT.ERROR,
  payload: message,
})

const loadSports = (page = 0) => ({
  type: LOAD_SPORTS.PENDING,
  payload: {
    page,
  },
})

const filterSports = filter => ({
  type: LOAD_SPORTS.PENDING,
  payload: {
    filter,
    page: 0,
  },
})

const sortSports = sort => ({
  type: LOAD_SPORTS.PENDING,
  payload: {
    sort,
  },
})

const resetSportsFilter = () => ({
  type: LOAD_SPORTS.PENDING,
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

const sportsLoaded = (sports, { filter, sort }) => ({
  type: LOAD_SPORTS.SUCCESS,
  payload: {
    sports,
    filter,
    sort,
  },
})

const sportLoadError = message => ({ type: LOAD_SPORTS.ERROR, payload: message })

export {
  LOAD_SPORTS,
  loadSports,

  CLEAR_LOADED_SPORT,
  clearLoadedSport,

  LOAD_SPORT,
  loadSport,
  loadSportSuccess,
  loadSportError,

  UPDATE_SPORT,
  updateSport,
  updateSportSuccess,
  updateSportError,

  filterSports,
  resetSportsFilter,
  sortSports,
  sportsLoaded,
  sportLoadError,
}
