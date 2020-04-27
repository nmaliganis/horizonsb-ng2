import {
  compose,
  omit,
} from 'ramda'

export const normalizePutData = payload => compose(
  item => ({
    ...item,
    favorite: payload.favorite,
  }),
  omit(['name', 'priority', 'tournamentId']),
)(payload)


export const normalizeGetData = () => compose(
  item => ({
    ...item,
    OrderColumn: 'LivePriority',
    OrderDirection: 'desc',
  }),
)()

