import styled from 'styled-components'
import { Link } from 'react-router-dom'

export const LogoContainer = styled.div`
  float: left;
`

export const LogoWrapper = styled(Link)`
  line-height: 70px;
  padding: 0;
  text-decoration: none;
  padding-right: 60px;
  float: left;

  svg {
    height: 25px;
    position: relative;
    top: 0.5rem;
  }
`

export const LogoLabel = styled.span`
  color: white;
  text-transform: uppercase;
  background: #424242;
  padding: 0.3rem 0.6rem;
  font-weight: bolder;
  font-size: 12px;
  border-radius: 0.25em;
  margin-left: 1rem;
`
