import {
  compose,
  omit,
} from 'ramda'

export const normalizePutData = payload => compose(
  item => ({
    ...item,
    newPriority: payload.priority,
    favorite: payload.favorite,
  }),
  omit(['name', 'priority', 'eventId']),
)(payload)

export const normalizeGetData = () => compose(
  item => ({
    ...item,
    OrderColumn: 'Priority',
    OrderDirection: 'desc',
  }),
)()


