import styled from 'styled-components'
import mq from 'styles/mq'
import { CloseIcon } from 'assets/icons'

export const Container = styled.div`
  padding: 5px 10px;
  color: #6cabca;
  line-height: 30px;
  border-radius: 2px;
  background-color: #ecf5f9;
  margin: 15px 0;
  ${mq.phone`
    margin-bottom: 0;
  `};
`

export const ResetButton = styled(CloseIcon)`
  float: right;
  margin-top: 8px;
  cursor: pointer;
`
