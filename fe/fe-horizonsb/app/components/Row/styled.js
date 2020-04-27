import styled from 'styled-components'
import mq from '../../styles/mq'

export const Row = styled.div`
  display: flex;

  ${mq.tablet`
    flex-direction: column;
  `};
`
