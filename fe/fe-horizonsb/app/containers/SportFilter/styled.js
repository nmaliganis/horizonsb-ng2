import styled from 'styled-components'
import { color, font, fontSize } from '../../styles/variables'

export const Panel = styled.nav`
  background-color: white;
  min-height: 68px;
  border-bottom: 2px solid #f0f0f0;
`

export const SearchButton = styled.button`
  background-color: ${props =>
    props.active ? color.paleBlue : color.mediumGray};
  color: white;
  text-transform: uppercase;
  font-family: ${font.riftSoft}, sans-serif;
  font-size: ${fontSize.default};
  border: none;
  line-height: 37px;
  min-width: 170px;
  border-radius: 4px;
  float: right;
  margin: 15px 0;

  &:hover {
    background-color: ${props => (props.active ? '#73b7d8' : color.mediumGray)};
    cursor: pointer;
  }
`
