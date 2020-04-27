import styled from 'styled-components'
import { font, color } from '../../styles/variables'

export const Panel = styled.div``

export const PanelContainer = styled.div`
  position: relative;
  display: block;
  padding: 10px 15px;
  margin-bottom: -1px;
  border: 1px solid #ddd;
  background-color: #fff;
  opacity: 1;
  transition: opacity 0.3s ease-in-out;

  ${props =>
    !props.isActive &&
    `
    opacity: 0.3;
  `} &:first-child {
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
  }

  &:last-child {
    border-bottom-right-radius: 4px;
    border-bottom-left-radius: 4px;
  }
`

export const PanelTitle = styled.div`
  text-transform: uppercase;
  font-family: ${font.riftSoft};
  font-weight: ${font.bold};
  color: ${color.muted};
  line-height: 20px;
  font-size: 16px;
  margin-bottom: 5px;
`

export const PanelValue = styled.div`
  font-size: 30px;
  line-height: 37px;
  font-weight: ${font.bold};
`
