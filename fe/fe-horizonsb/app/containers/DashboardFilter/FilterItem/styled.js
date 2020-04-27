import styled from 'styled-components'

import { color } from 'styles/variables'

export const ListItem = styled.li`
  float: left;
  margin-bottom: 0;
  margin-right: 2.5rem;
  position: relative;
  border-bottom: 2px solid
    ${props => (props.active ? color.orange : 'transparent')};
  line-height: 70px;
  cursor: pointer;
`
