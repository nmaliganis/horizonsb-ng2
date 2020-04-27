import styled, { css } from 'styled-components'
import mq from '../../styles/mq'
import { color, font, fontSize } from '../../styles/variables'

export default styled.button`
  background-color: ${color.orange};
  padding: 15px 20px;
  border: none;
  text-transform: uppercase;
  font-family: ${font.riftSoft}, sans-serif;
  font-size: ${fontSize.default};
  font-weight: ${font.bold};
  letter-spacing: 1px;
  line-height: 17px;
  height: 55px;
  margin-top: 25px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  min-width: 360px;
  border-radius: 4px;
  box-shadow: 0 2px 18px 0 rgba(146, 146, 146, 0);
  &:hover {
    background-color: #f0310d;
  }
  span {
    color: white;
  }
  svg {
    margin-right: 20px;
  }
  ${({disabled}) => disabled &&
    `
    background-color: ${color.darkGray};
    cursor: not-allowed;
    &:hover { background-color: ${color.darkGray}; }
    `
  }
  ${({ btnType }) =>
    btnType === 'download' &&
    css`
      svg {
        transform: rotate(180deg);
      }
    `};
  ${mq.phone`
    min-width: 100%;
  `};
`
