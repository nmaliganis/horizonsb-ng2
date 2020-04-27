import styled from 'styled-components'
import mq from '../../styles/mq'
import { is } from '../../utils/styled-is'

export const Container = styled.section`
  margin-right: auto;
  margin-left: auto;
  display: flex;
  //width: 1120px;
  width: 1420px;

  ${is('isColumn')`
    flex-direction: column;
  `}

  ${mq.tablet`
    width: 970px;
  `} ${mq.phone`
    width: 100%;
    display: block;
  `};
`
