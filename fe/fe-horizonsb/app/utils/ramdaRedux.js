import {
  compose,
  equals,
  identity,
  ifElse,
  map,
  not,
  over,
  prop,
  lensProp,
  filter,
} from 'ramda'

export const mapIfId = id => callback => map(
  ifElse(
    compose(
      equals(id),
      prop('id')
    ),
    callback,
    identity,
  )
)

export const toggleProp = propName => over(lensProp(propName), not)

export const toggleItemIsDeleting = id =>
  mapIfId(id)(toggleProp('isDeleting'))

export const removeById = id => filter(
  compose(
    not,
    equals(id),
    prop('id'),
  )
)
