import React, { Fragment } from 'react'
import { TOURNAMENTS_MENU_ITEMS } from '../constants'
import Nav from '../components/Nav'
import Container from '../components/Container'
import EventsMenu from '../components/Menu'
import TournamentsTable from '../containers/TournamentTable'
import ErrorMessage from '../containers/ErrorMessage'
import Column from '../components/Column'

const Tournaments = () => (
  <Fragment>
    <Nav />
    <EventsMenu menuItems={TOURNAMENTS_MENU_ITEMS} />
    <ErrorMessage />
    <Container>
      <Column width={100}>
        <TournamentsTable />
      </Column>
    </Container>
  </Fragment>
)

export default Tournaments
