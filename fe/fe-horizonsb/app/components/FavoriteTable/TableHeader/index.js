import React from 'react'
import Label from '../../Table/TableHeader/Label'
import {
  HeaderContainer,
  WideColumn,
  NormalColumn,
  ThinColumn
} from '../../Table/TableHeader/styled'

const TableHeader = () => (
  <HeaderContainer>
    <WideColumn>
      <Label displayName="Event Name" />
    </WideColumn>
    <NormalColumn>
      <Label displayName="Event ID" />
    </NormalColumn>
    <NormalColumn>
      <Label displayName="Sport" />
    </NormalColumn>
    <NormalColumn>
      <Label displayName="Tournament" />
    </NormalColumn>
    <NormalColumn>
      <Label displayName="Event Date" />
    </NormalColumn>
    <ThinColumn />
  </HeaderContainer>
)

export default TableHeader
