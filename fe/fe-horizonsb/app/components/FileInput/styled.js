import styled from 'styled-components'
import GenericButton from "../Button"
import { color } from '../../styles/variables'

export const Button = styled(GenericButton)`
  display: block;
  background: ${color.lightGray};

  &:hover {
    background: ${color.mediumGray};
  }

  span {
    color: ${color.darkGray};
  }
`

export const Image = styled.img`
  display: block;
  width: 200px;
  border: 1px solid ${color.mediumGray};
  padding: 5px;
  border-radius: 5px;
`
