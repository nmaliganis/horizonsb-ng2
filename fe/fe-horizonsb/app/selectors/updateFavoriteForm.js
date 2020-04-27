import {
  head,
  last,
  ifElse,
  applySpec,
  prop,
  identity,
  compose,
} from 'ramda'

const updateFavoriteFormSelector =
  state => ({
    isUpdating: state.favorites.isUpdating,
    entry: ifElse(
      identity,
      applySpec({
        id: prop('Id'),
        name: prop('Name'),
        eventId: prop('EventId'),
        favorite: prop('Favorite'),
      }),
      identity,
    )(state.favorites.entry),
  })

export { updateFavoriteFormSelector }
