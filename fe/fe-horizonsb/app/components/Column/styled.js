import styled from 'styled-components'
import mq from '../../styles/mq'

export const Column = styled.div`
  padding-left: 10px;
  padding-right: 10px;
  flex: 0 0 ${props => props.width}%;
  box-sizing: border-box;

  ${mq.phone`
    width: 100%;
    display: inline-block;
  `};
`
