import React, { Fragment } from 'react'
import { EVENTS_MENU_ITEMS } from '../constants'
import Nav from '../components/Nav'
import Container from '../components/Container'
import EventsMenu from '../components/Menu'
import ErrorMessage from '../containers/ErrorMessage'
import Column from '../components/Column'
import EventsTable from '../containers/EventTable'

const Events = () => (
  <Fragment>
    <Nav />
    <EventsMenu menuItems={EVENTS_MENU_ITEMS} />
    <ErrorMessage />
    <Container>
      <Column width={100}>
        <EventsTable />
      </Column>
    </Container>
  </Fragment>
)

export default Events
