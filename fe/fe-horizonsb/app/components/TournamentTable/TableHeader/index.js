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
      <Label displayName="Name" />
    </WideColumn>
    <NormalColumn>
      <Label displayName="Tournament ID" />
    </NormalColumn>
    <NormalColumn>
      <Label displayName="Priority" />
    </NormalColumn>
    <NormalColumn>
      <Label displayName="Number Of Events" />
    </NormalColumn>
    <ThinColumn />
  </HeaderContainer>
)

export default TableHeader
