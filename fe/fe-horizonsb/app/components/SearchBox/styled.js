import styled from 'styled-components'
import { SearchIcon as Icon } from 'assets/icons'
import mq from 'styles/mq'

export const Container = styled.div`
  border: 1px solid #d8d8d8;
  border-radius: 3px;
  height: 38px;
  margin: 15px 0;
  display: flex;

  ${mq.phone`
    margin-bottom: 0;
  `} input {
    border: none;

    &:focus {
      outline: 0;
    }
  }
`

export const SearchIcon = styled(Icon)`
  height: 40px;
  width: 20px;
  padding: 0 10px;
`
