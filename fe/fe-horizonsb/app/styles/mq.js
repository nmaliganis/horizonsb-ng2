import { css } from 'styled-components'
import breakpoints from './breakpoints'

const mq = Object.keys(breakpoints).reduce((accumulator, breakpoint) => {
  accumulator[breakpoint] = (...args) => css`
    @media (max-width: ${breakpoints[breakpoint]}em) {
      ${css(...args)};
    }
  `
  return accumulator
}, {})

export default mq
