import React from 'react'
import PropTypes from 'prop-types'
import { Provider } from 'react-redux'
import { Router, Route, Switch, Redirect } from 'react-router-dom'
import { createBrowserHistory } from 'history'
import 'styles/global-styles'
import 'styles/FontFaceObserver'
import PrivateRoute from "../PrivateRoute"
import Home from '../../pages/Home'
import NotFound from '../../pages/NotFound'
import Dashboard from '../../pages/Dashboard'
import Sports from '../../pages/Sports'
import SportsUpdate from '../../pages/SportsUpdate'
import SignOut from '../../pages/Signout'
import Events from '../../pages/Events'
import EventsUpdate from '../../pages/EventsUpdate'
import Tournaments from '../../pages/Tournaments'
import TournamentsUpdate from '../../pages/TournamentsUpdate'
import Lives from '../../pages/Lives'
import Favorites from '../../pages/Favorites'
import LivesUpdate from '../../pages/LivesUpdate'
import FavoritesUpdate from '../../pages/FavoritesUpdate'

export const history = createBrowserHistory()

const App = ({ store }) => (
  <Provider store={store}>
    <Router history={history}>
      <Switch>
        <Redirect exact from="/home" to="/" />
        <Route exact path="/" component={Home} />
        <Route exact path="/dashboard" component={Dashboard} />
        <Route exact path="/sports" component={Sports} />
        <Route exact path="/sports/update/:id" component={SportsUpdate} />
        <Route exact path="/signout" component={SignOut} />
        <Redirect exact from="/events" to="/events/list" />
        <Route exact path="/events/update/:id" component={EventsUpdate} />
        <Route exact path="/events/list" component={Events} />
        <Redirect exact from="/tournaments" to="/tournaments/list" />
        <Route exact path="/tournaments/list" component={Tournaments} />
        <Route exact path="/tournaments/update/:id" component={TournamentsUpdate} />
        <Redirect exact from="/favorites" to="/favorites/list" />
        <Redirect exact from="/lives" to="/lives/list" />
        <Route exact path="/favorites/list" component={Favorites} />
        <Route exact path="/favorites/update/:id" component={FavoritesUpdate} />
        <Route exact path="/lives/list" component={Lives} />
        <Route exact path="/lives/update/:id" component={LivesUpdate} />
        <Route component={NotFound} />
      </Switch>
    </Router>
  </Provider>
)

App.propTypes = {
  store: PropTypes.object.isRequired,
}

export default App
