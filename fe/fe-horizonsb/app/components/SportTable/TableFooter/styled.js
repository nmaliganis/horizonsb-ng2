import styled from 'styled-components'
import { color } from '../../../styles/variables'

const ArrowButton = styled.div`
  width: 36px;
  border: 1px solid ${color.mediumGray};
  border-radius: 2px;
  background: #fff;
  height: 36px;
  line-height: 36px;
  text-align: center;
  font-size: 10px;
  cursor: pointer;
  user-select: none;
  visibility: ${props => (props.active ? 'visible' : 'hidden')};
`

export const FooterContainer = styled.div`
  padding-top: 15px;
  display: flex;
`

export const PrevArrow = styled(ArrowButton)`
  flex: 36px 0 0;
`

export const NextArrow = styled(ArrowButton)`
  flex: 0 0 36px;
`
