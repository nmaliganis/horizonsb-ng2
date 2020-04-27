import {
  compose,
  omit,
} from 'ramda'

export const normalizePutData = payload => compose(
  item => ({
    ...item,
    newPriority: payload.priority,
  }),
  omit(['name', 'priority', 'tournamentId']),
)(payload)


