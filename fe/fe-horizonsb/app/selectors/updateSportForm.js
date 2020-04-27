import {
  ifElse,
  applySpec,
  prop,
  identity,
} from 'ramda'

const updateSportFormSelector =
  state => ({
    isUpdating: state.sports.isUpdating,
    entry: ifElse(
      identity,
      applySpec({
        id: prop('id'),
        name: prop('name'),
        sportId: prop('sportId'),
        priority: prop('priority'),
      }),
      identity,
    )(state.sports.entry),
  })

export { updateSportFormSelector }
