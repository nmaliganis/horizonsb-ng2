import React, { Fragment } from 'react'
import Nav from '../components/Nav'
import EventsMenu from '../components/Menu'
import { LIVES_MENU_ITEMS } from '../constants'
import ErrorMessage from '../containers/ErrorMessage'
import Container from '../components/Container'
import Column from '../components/Column'
import LivesTable from '../containers/LiveTable'

const Lives = () => (
  <Fragment>
    <Nav />
    <EventsMenu menuItems={LIVES_MENU_ITEMS} />
    <ErrorMessage />
    <Container>
      <Column width={100}>
        <LivesTable />
      </Column>
    </Container>
  </Fragment>
)

export default Lives
