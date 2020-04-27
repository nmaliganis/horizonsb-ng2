import styled from 'styled-components'

import { ViewIcon, CloseIcon } from 'assets/icons'
import { font, color, fontSize } from 'styles/variables'
import Button from 'components/Button'
import { is } from 'utils/styled-is'

const OverflowLabel = styled.div`
  overflow: auto;
  text-overflow: ellipsis;
`

export const Row = styled.div`
  display: flex;
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

export const NameLabel = styled(OverflowLabel)`
  font-weight: bold;
  flex: 2;
`

export const DateLabel = styled(OverflowLabel)`
  flex: 1;
`

export const WideLabel = styled(OverflowLabel)`
  font-weight: bold;
  flex: 2;
`

export const NormalLabel = styled(OverflowLabel)`
  flex: 1;
`

export const SerialNumberLabel = styled(OverflowLabel)`
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

export const EditButton = styled(Button)`
  min-width: auto;
  height: auto;
  width: auto;
  margin-right: 10px;
  padding: 12.5px 10px;
  margin-top: 10px;
`

export const UserDetailButton = styled(Button)`
  min-width: auto;
  height: auto;
  width: auto;
  margin-right: 10px;
  padding: 12.5px 10px;
  
  ${is('disabled')`
    background-color: ${color.mediumGray};
  `}
  
  &:hover {
    ${is('disabled')`
      background-color: ${color.mediumGray};
    `}
  }
`

export const UserDetailBoardButton = styled(UserDetailButton)`
  padding: 5px;
  margin: 0;
  font-size: 14px;
`

export const Body = styled.div`
  display: flex;
  padding: 0 30px 20px;
  user-select: none;
  flex-direction: column;
`

export const UserDetailActionsBox = styled.div`
  margin-top: 40px;
`

export const UserDetailsBox = styled.div`
  display: flex;
  flex-direction: column;
  flex: 2;
`

export const BoardDetailsBox = styled.div`
  flex: 2.5;
`

export const BoardLabel = styled.div`
  display: flex;
  font-size: ${fontSize.default};
  margin: 15px 0;
`

export const BoardNameLabel = styled.div`
  flex: 1;
`

export const BoardSerialLabel = styled.div`
  flex: 1.5;
`

export const EmailBox = styled.div``

export const WeightHeightBox = styled.div`
  display: flex;
  margin-top: 40px;
`

export const GenderBox = styled.div`
  flex: 1;
`

export const WeightBox = styled.div`
  flex: 1;
`

export const HeightBox = styled.div`
  flex: 2;
`

export const CaptionLabel = styled.div`
  text-transform: uppercase;
  font-family: ${font.riftSoft};
  font-weight: ${font.bold};
  color: ${color.muted};
  font-size: 16px;
`

export const ValueLabel = styled(OverflowLabel)`
  margin-top: 15px;
`
