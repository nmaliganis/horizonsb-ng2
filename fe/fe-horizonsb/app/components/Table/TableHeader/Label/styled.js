import styled from 'styled-components'

export const Container = styled.div`
  cursor: ${props => (props.sortable ? 'pointer' : 'default')};
  user-select: none;
`
