import React, {
  Component,
  Fragment,
} from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import UpdateTournamentForm from '../forms/Tournament'
import { TOURNAMENTS_MENU_ITEMS } from '../constants'
import { updateTournamentFormSelector } from '../selectors/updateTournamentForm'
import {
  updateTournament,
  loadTournament,
  clearLoadedTournament,
} from '../actions/tournaments'
import Nav from '../components/Nav/index'
import Container from '../components/Container/index'
import EventsMenu from '../components/Menu/index'
import Content from '../components/Content/index'
import Column from '../components/Column/index'
import ErrorMessage from '../containers/ErrorMessage/index'

const getMenuItems =
  id => [
    ...TOURNAMENTS_MENU_ITEMS,
    {
      label: 'Update Tournament',
      to: `/tournaments/update/${id}`,
    },
  ]

class TournamentsUpdate extends Component {
  componentDidMount() {
    this.props.dispatchLoadTournament(this.props.match.params.id)
  }

  componentWillUnmount() {
    this.props.dispatchClearLoadedTournament()
  }

  render() {
    const { dispatchUpdateTournament, isUpdating, entry, match } = this.props

    return (
      <Fragment>
        <Nav />
        <EventsMenu menuItems={getMenuItems(match.params.id)} />
        <ErrorMessage />
        <Container isColumn>
          {entry && (
            <Column width={100}>
              <h2>Update Tournament</h2>
              <Content isColumn>
                <UpdateTournamentForm
                  initial={entry}
                  isLoading={isUpdating}
                  submit={dispatchUpdateTournament}
                />
              </Content>
            </Column>
          )}
        </Container>
      </Fragment>
    )
  }
}

TournamentsUpdate.defaultProps = {
  entry: null,
}

TournamentsUpdate.propTypes = {
  dispatchClearLoadedTournament: PropTypes.func.isRequired,
  dispatchLoadTournament: PropTypes.func.isRequired,
  dispatchUpdateTournament: PropTypes.func.isRequired,
  entry: PropTypes.shape({
    id: PropTypes.string,
    name: PropTypes.string,
    tournamentId: PropTypes.string,
    priority: PropTypes.number,
  }),
  isUpdating: PropTypes.bool.isRequired,
  match: PropTypes.shape({
    params: PropTypes.shape({
      id: PropTypes.string,
    }),
  }).isRequired,
}

export default connect(
  state => updateTournamentFormSelector(state), {
    dispatchUpdateTournament: updateTournament,
    dispatchLoadTournament: loadTournament,
    dispatchClearLoadedTournament: clearLoadedTournament,
  })(TournamentsUpdate)
