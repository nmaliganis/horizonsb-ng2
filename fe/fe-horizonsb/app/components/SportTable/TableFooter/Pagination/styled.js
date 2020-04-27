import styled from 'styled-components'

export const PaginationContainer = styled.div`
  margin: 0 auto;
  display: flex;
  align-items: center;
`

export const PageItem = styled.span`
  background-color: ${props => (props.active ? '#E3ECF0' : 'transparent')};
  margin-right: 4px;
  border-radius: 2px;
  height: 25px;
  display: inline-block;
  width: 25px;
  text-align: center;
  cursor: pointer;
  color: ${props => (props.active ? '#57ACCD' : '#737373')};
  line-height: 25px;
  user-select: none;
`
