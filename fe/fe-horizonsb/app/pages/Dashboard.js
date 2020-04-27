import React, { Fragment } from 'react'
import Nav from '../components/Nav'
import Container from '../components/Container'
import Column from '../components/Column'
import TournamentsSummary from '../containers/TournamentsSummary'
import SportSummary from '../containers/SportSummary'
import EventsSummary from '../containers/EventsSummary'
import MarketsSummary from '../containers/MarketsSummary'
import LivesSummary from '../containers/LivesSummary'
import ErrorMessage from '../containers/ErrorMessage'
import { Row } from 'components/SportTable/TableRow/styled'

const Dashboard = () => (
  <Fragment>
    <Nav />
    {/*<DashboardFilter />*/}
    <ErrorMessage />
    <Container>
      <Column width={20}>
        <SportSummary />
      </Column>
      <Column width={20}>
        <TournamentsSummary />
      </Column>
      <Column width={20}>
        <EventsSummary />
      </Column>
      <Column width={20}>
        <MarketsSummary />
      </Column>
      <Column width={20}>
        <LivesSummary />
      </Column>
    </Container>
  </Fragment>
)

export default Dashboard
