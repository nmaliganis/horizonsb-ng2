import { createActionSet } from '../utils/actionHelper'

const LOAD_EVENT = createActionSet('event')
const LOAD_EVENTS = createActionSet('events')
const UPDATE_EVENT = createActionSet('updateEvent')
const DELETE_EVENT = createActionSet('deleteEvent')
const CHANGE_PAGE = 'events/CHANGE_PAGE'
const CLEAR_LOADED_EVENT = 'event/CLEAR_LOADED'

const clearLoadedEvent = () => ({
  type: CLEAR_LOADED_EVENT,
})

const loadEvent = (id) => ({
  type: LOAD_EVENT.PENDING,
  payload: {
    id,
  }
})

const loadEventSuccess = payload => ({
  type: LOAD_EVENT.SUCCESS,
  payload,
})

const loadEventError = message => ({
  type: LOAD_EVENT.ERROR,
  payload: message,
})

const updateEvent = payload => ({
  type: UPDATE_EVENT.PENDING,
  payload,
})

const updateEventSuccess = payload => ({
  type: UPDATE_EVENT.SUCCESS,
  payload,
})

const updateEventError = message => ({
  type: UPDATE_EVENT.ERROR,
  payload: message,
})

const deleteEvent = payload => ({
  type: DELETE_EVENT.PENDING,
  payload,
})

const loadEvents = () => ({
    type: LOAD_EVENTS.PENDING,
})

const eventsLoaded =
  events => ({
    type: LOAD_EVENTS.SUCCESS,
    payload: {
      events,
    },
  })

const eventsLoadError =
  message => ({
    type: LOAD_EVENTS.ERROR,
    payload: message,
  })

const changePage =
  pageNumber =>
    ({
      type: CHANGE_PAGE,
      payload: {
        pageNumber,
      },
    })

export {
  LOAD_EVENTS,
  loadEvents,
  eventsLoaded,
  eventsLoadError,
  CHANGE_PAGE,
  changePage,
  UPDATE_EVENT,
  updateEvent,
  updateEventSuccess,
  updateEventError,
  LOAD_EVENT,
  loadEvent,
  loadEventSuccess,
  loadEventError,
  clearLoadedEvent,
  CLEAR_LOADED_EVENT,
  DELETE_EVENT,
  deleteEvent,
}
