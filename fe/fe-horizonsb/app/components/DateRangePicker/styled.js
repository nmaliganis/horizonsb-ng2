import styled from 'styled-components'
import mq from '../../styles/mq'

export const DatePickerWrapper = styled.span`
  flex: 1;
  text-align: center;

  input {
    width: auto;
    border: 1px solid #ddd;
    margin-top: 15px;

    &:focus {
      outline: none;
    }

    ${mq.phone`
      max-width: 130px;
    `};
  }

  &:last-child {
    margin-left: 10px;
  }
`

export const DatePickerContainer = styled.div`
  display: flex;
  float: right;

  ${mq.phone`
    float: none;
    margin-bottom: 10px;
  `};
`
