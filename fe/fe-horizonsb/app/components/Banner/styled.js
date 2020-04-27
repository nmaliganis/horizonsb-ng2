import styled from 'styled-components'
import mq from '../../styles/mq'
import { color } from '../../styles/variables'

export const Banner = styled.section`
  background-color: ${color.darkGray};
  color: white;
  position: fixed;
  bottom: 0;
  width: 100%;
  top: 0;
  display: flex;
  align-items: center;

  div {
    margin-left: 160px;

    p {
      color: #f12d2d;
    }

    h1 {
      color: white;
      font-size: 40px;
      margin-top: 100px;
      letter-spacing: -1px;
      margin-bottom: 25px;
      line-height: 44px;
    }
  }

  ${mq.phone`
    div {
      margin: 0 20px;
      text-align: center;
    }

    a {
      width: 100%;
    }
  `};
`
