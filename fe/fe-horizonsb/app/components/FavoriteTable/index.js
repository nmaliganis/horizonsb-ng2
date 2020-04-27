import React from 'react'
import Table from '../Table'
import TableHeader from './TableHeader'
import TableRow from './TableRow'

const FavoriteTable = ({  ...props }) => (
  <Table
    renderHeader={componentProps => <TableHeader {...componentProps} />}
    renderRow={componentProps => <TableRow {...componentProps} />}
    {...props}
  />
)

export default FavoriteTable
