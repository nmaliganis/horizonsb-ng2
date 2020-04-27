import {
  head,
  last,
  ifElse,
  applySpec,
  prop,
  identity,
  compose,
} from 'ramda'

const updateEventFormSelector =
  state => ({
    isUpdating: state.lives.isUpdating,
    entry: ifElse(
      identity,
      applySpec({
        id: prop('Id'),
        name: prop('Name'),
        eventId: prop('EventId'),
        priority: prop('Priority'),
        favorite: prop('Favorite'),
      }),
      identity,
    )(state.events.entry),
  })

export { updateEventFormSelector }
