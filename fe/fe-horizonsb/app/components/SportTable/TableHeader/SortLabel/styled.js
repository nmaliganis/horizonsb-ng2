import styled from 'styled-components'

export const SortContainer = styled.div`
  cursor: ${props => (props.sortable ? 'pointer' : 'default')};
  user-select: none;
`
