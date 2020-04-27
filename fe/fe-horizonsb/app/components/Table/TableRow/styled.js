import styled from 'styled-components'
import Button from "../../Button"
import {
  color,
  font,
} from '../../../styles/variables'
import { is } from '../../../utils/styled-is'
import { ViewIcon, CloseIcon } from '../../../assets/icons'

const OverflowLabel = styled.div`
  overflow: auto;
  text-overflow: ellipsis;
`

export const RowContainer = styled.div`
  border-bottom: 1px solid ${color.mediumGray};
  background-color: ${props => (props.isOpen ? '#fafafa' : '#ffffff')};
  border-left: 1px solid ${color.mediumGray};
  border-right: 1px solid ${color.mediumGray};
`

export const Head = styled.div`
  display: flex;
  padding: 20px 30px;
  line-height: 1.6;
`

export const WideLabel = styled(OverflowLabel)`
  font-weight: bold;
  flex: 2;
`

export const NormalLabel = styled(OverflowLabel)`
  flex: 1;
`

export const ActionBox = styled.div`
  flex: 0.5;
  display: flex;
  align-items: center;
  justify-content: flex-end;
`

export const ViewButton = styled(ViewIcon)`
  cursor: pointer;
  width: 20px;
`

export const CloseButton = styled(CloseIcon)`
  cursor: pointer;
  width: 20px;
`

export const Body = styled.div`
  display: flex;
  padding: 0 30px 20px;
  user-select: none;
  flex-direction: column;
`

export const Image = styled.img`
  width: 200px;
  height: 200px;
  object-fit: cover;
  border: 3px solid white;
  box-shadow: rgba(0, 0, 0, 0.2) 0 1px 5px;
`

export const Label = styled.div`
  text-transform: uppercase;
  font-family: ${font.riftSoft};
  font-weight: ${font.bold};
  color: ${color.muted};
  font-size: 16px;
  margin-bottom: 5px;
`

export const EditButton = styled(Button)`
  min-width: auto;
  height: auto;
  width: auto;
  margin-right: 10px;
  padding: 12.5px 10px;
  margin-top: 10px;
`

export const ContentRow = styled.div`
  display: flex;
  margin-top: 20px;

  a {
    color: ${color.orange};
    text-decoration: underline;
  }

  &:first-child {
    margin-top: 0;
  }

  ${is('isColumn')`
    flex-direction: column;
  `}

`

export const ContentColumn = styled.div`
  flex: 2;
`

export const DateColumn = styled.div`
  flex: 1.5;
`

export const ContentLabel = styled.div`
  text-transform: uppercase;
  font-family: ${font.riftSoft};
  font-weight: ${font.bold};
  color: ${color.muted};
  font-size: 16px;
`

export const ContentValue = styled(ContentLabel)`
  margin-top: 15px;
  color: black;
  word-break: break-all;
`
