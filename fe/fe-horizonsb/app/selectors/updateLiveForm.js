import {
  head,
  last,
  ifElse,
  applySpec,
  prop,
  identity,
  compose,
} from 'ramda'

const updateLiveFormSelector =
  state => ({
    isUpdating: state.lives.isUpdating,
    entry: ifElse(
      identity,
      applySpec({
        id: prop('Id'),
        name: prop('Name'),
        eventId: prop('EventId'),
        livePriority: prop('LivePriority'),
      }),
      identity,
    )(state.lives.entry),
  })

export { updateLiveFormSelector }
