import { css } from 'styled-components'

export const is = propKey => (...args) => props => props[propKey] && css(...args)
