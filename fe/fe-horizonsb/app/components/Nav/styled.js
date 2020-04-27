import styled from 'styled-components'
import { color } from '../../styles/variables'
import mq from '../../styles/mq'

export const Panel = styled.nav`
  background-color: ${color.darkGray};
  min-height: 70px;
  font-size: 16px;
`

export const LogoContainer = styled.div`
  ${mq.phone`
    text-align: center;
    a {
      float: none;
      padding: 0;
    }
  `};
`

export const Navigation = styled.ul`
  float: left;
  list-style: none;

  > li {
    float: left;
    margin-bottom: 0;
    margin-left: 40px;
    position: relative;

    &:first-child {
      margin-left: 0;
    }

    > a {
      color: white;
      display: inline;
      line-height: 70px;
      opacity: 0.75;
      padding: 0;
      text-decoration: none;

      &.active {
        opacity: 1;
      }
    }
  }
`
