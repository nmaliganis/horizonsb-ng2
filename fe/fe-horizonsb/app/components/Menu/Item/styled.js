import styled from 'styled-components'
import { NavLink } from 'react-router-dom'
import { color } from 'styles/variables'

export const MenuItem = styled(NavLink)`
  float: left;
  margin-bottom: 0;
  margin-right: 2.5rem;
  position: relative;
  border-bottom: 2px solid transparent;
  line-height: 70px;
  cursor: pointer;
  
  &[aria-current="true"] {
    border-bottom: 2px solid ${color.orange};
  }
`
