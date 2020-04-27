import styled from 'styled-components'
import mq from '../../styles/mq'
import { is } from '../../utils/styled-is'

export const Label = styled.span`
  font-weight: bold;
`

export const Error = styled.span`
  background-color: #f0310d;
  color: white;
  display: flex;
  padding: 5px 10px;
  border-radius: 4px;
  font-size: 13px;
  margin-bottom: 15px;
`

export const ElementContainer = styled.div`
  border: 1px solid #d8d8d8;
  border-radius: 3px;
  height: 38px;
  margin: 15px 0;
  display: flex;

  ${is('isHidden')`
    display: none;
  `}

  ${mq.phone`
    margin-bottom: 0;
  `}

  input,
  textarea {
    border: none;

    &:focus {
      outline: 0;
    }
  }
`
