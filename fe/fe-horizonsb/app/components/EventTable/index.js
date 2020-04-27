import React from 'react'
import PropTypes from 'prop-types'
import Table from '../Table'
import TableHeader from './TableHeader'
import TableRow from './TableRow'

const EventTable = ({ onRowDelete, ...props }) => (
  <Table
    renderHeader={componentProps => <TableHeader {...componentProps} />}
    renderRow={componentProps => <TableRow {...componentProps} />}
    {...props}
  />
)

export default EventTable
