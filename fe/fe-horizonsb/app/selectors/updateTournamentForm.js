import {
  head,
  last,
  ifElse,
  applySpec,
  prop,
  identity,
  compose,
} from 'ramda'

const updateTournamentFormSelector =
  state => ({
    isUpdating: state.tournaments.isUpdating,
    entry: ifElse(
      identity,
      applySpec({
        id: prop('id'),
        name: prop('name'),
        tournamentId: prop('tournamentId'),
        priority: prop('priority'),
      }),
      identity,
    )(state.tournaments.entry),
  })

export { updateTournamentFormSelector }
