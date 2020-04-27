import React from 'react'
import SortLabel from './SortLabel'
import {
  HeaderContainer,
  WideColumn,
  NormalColumn,
  ThinColumn,
} from './styled'

const TableHeader = props => (
  <HeaderContainer>
    <WideColumn>
      <SortLabel displayName="Name" name="name" {...props} />
    </WideColumn>
    <NormalColumn>
      <SortLabel displayName="Sport Id" name="sportId" {...props} />
    </NormalColumn>
    <NormalColumn>
      <SortLabel displayName="Priority" name="priority" {...props} />
    </NormalColumn>
    <NormalColumn>
      <SortLabel
        displayName="Number Of Events"
        name="numberOfEvents"
        sortable={false}
        {...props}
      />
    </NormalColumn>
    <ThinColumn />
  </HeaderContainer>
)

export default TableHeader
