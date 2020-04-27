import React, { Fragment } from 'react'
import Nav from '../components/Nav'
import EventsMenu from '../components/Menu'
import { FAVORITES_MENU_ITEMS } from '../constants'
import ErrorMessage from '../containers/ErrorMessage'
import Container from '../components/Container'
import Column from '../components/Column'
import FavoritesTable from '../containers/FavoriteTable'

const Favorites = () => (
  <Fragment>
    <Nav />
    <EventsMenu menuItems={FAVORITES_MENU_ITEMS} />
    <ErrorMessage />
    <Container>
      <Column width={100}>
        <FavoritesTable />
      </Column>
    </Container>
  </Fragment>
)

export default Favorites
