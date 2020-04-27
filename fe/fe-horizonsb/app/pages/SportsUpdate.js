import React, {
  Component,
  Fragment,
} from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import UpdateSportForm from '../forms/Sport'
import { SPORTS_MENU_ITEMS } from '../constants'
import { updateSportFormSelector } from '../selectors/updateSportForm'
import {
  updateSport,
  loadSport,
  clearLoadedSport,
} from '../actions/sports'
import Nav from '../components/Nav/index'
import Container from '../components/Container/index'
import EventsMenu from '../components/Menu/index'
import Content from '../components/Content/index'
import Column from '../components/Column/index'
import ErrorMessage from '../containers/ErrorMessage/index'

const getMenuItems =
  id => [
    ...SPORTS_MENU_ITEMS,
    {
      label: 'Update Sport',
      to: `/sports/update/${id}`,
    },
  ]

class SportsUpdate extends Component {
  componentDidMount() {
    this.props.dispatchLoadSport(this.props.match.params.id)
  }

  componentWillUnmount() {
    this.props.dispatchClearLoadedSport()
  }

  render() {
    const { dispatchUpdateSport, isUpdating, entry, match } = this.props

    return (
      <Fragment>
        <Nav />
        <EventsMenu menuItems={getMenuItems(match.params.id)} />
        <ErrorMessage />
        <Container isColumn>
          {entry && (
            <Column width={100}>
              <h2>Update Sport</h2>
              <Content isColumn>
                <UpdateSportForm
                  initial={entry}
                  isLoading={isUpdating}
                  submit={dispatchUpdateSport}
                />
              </Content>
            </Column>
          )}
        </Container>
      </Fragment>
    )
  }
}

SportsUpdate.defaultProps = {
  entry: null,
}

SportsUpdate.propTypes = {
  dispatchClearLoadedSport: PropTypes.func.isRequired,
  dispatchLoadSport: PropTypes.func.isRequired,
  dispatchUpdateSport: PropTypes.func.isRequired,
  entry: PropTypes.shape({
    id: PropTypes.string,
    name: PropTypes.string,
    sportId: PropTypes.string,
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
  state => updateSportFormSelector(state), {
    dispatchUpdateSport: updateSport,
    dispatchLoadSport: loadSport,
    dispatchClearLoadedSport: clearLoadedSport,
  })(SportsUpdate)
