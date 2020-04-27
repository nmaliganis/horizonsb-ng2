import styled from 'styled-components'
import { font, color } from '../../../styles/variables'

const Column = styled.div`
  span {
    color: ${color.muted};
  }

  svg {
    margin-left: 5px;
    cursor: pointer;
  }
`

export const HeaderContainer = styled.div`
  display: flex;
  padding: 20px 30px;
  text-transform: uppercase;
  font-family: ${font.riftSoft};
  font-weight: ${font.bold};
  border: 1px solid ${color.mediumGray};
  border-radius: 4px 4px 0 0;
  font-size: 16px;
  background-color: #fff;
`

export const WideColumn = styled(Column)`
  flex: 2;
`

export const NormalColumn = styled(Column)`
  flex: 1;
`

export const ThinColumn = styled(Column)`
  flex: 0.5;
`
