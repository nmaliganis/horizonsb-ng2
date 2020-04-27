import React, {
  Component,
  Fragment,
} from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import UpdateLiveForm from '../forms/Live'
import { LIVES_MENU_ITEMS } from '../constants'
import { updateLiveFormSelector } from '../selectors/updateLiveForm'
import {
  updateLive,
  loadLive,
  clearLoadedLive,
} from '../actions/liveevents'
import Nav from '../components/Nav/index'
import Container from '../components/Container/index'
import EventsMenu from '../components/Menu/index'
import Content from '../components/Content/index'
import Column from '../components/Column/index'
import ErrorMessage from '../containers/ErrorMessage/index'

const getMenuItems =
  id => [
    ...LIVES_MENU_ITEMS,
    {
      label: 'Update Live',
      to: `/lives/update/${id}`,
    },
  ]

class LivesUpdate extends Component {
  componentDidMount() {
    this.props.dispatchLoadLive(this.props.match.params.id)
  }

  componentWillUnmount() {
    this.props.dispatchClearLoadedLive()
  }

  render() {
    const { dispatchUpdateLive, isUpdating, entry, match } = this.props

    return (
      <Fragment>
        <Nav />
        <EventsMenu menuItems={getMenuItems(match.params.id)} />
        <ErrorMessage />
        <Container isColumn>
          {entry && (
            <Column width={100}>
              <h2>Update Live</h2>
              <Content isColumn>
                <UpdateLiveForm
                  initial={entry}
                  isLoading={isUpdating}
                  submit={dispatchUpdateLive}
                />
              </Content>
            </Column>
          )}
        </Container>
      </Fragment>
    )
  }
}

LivesUpdate.defaultProps = {
  entry: null,
}

LivesUpdate.propTypes = {
  dispatchClearLoadedLive: PropTypes.func.isRequired,
  dispatchLoadLive: PropTypes.func.isRequired,
  dispatchUpdateLive: PropTypes.func.isRequired,
  entry: PropTypes.shape({
    id: PropTypes.string,
    name: PropTypes.string,
    eventId: PropTypes.string,
    livePriority: PropTypes.number,
  }),
  isUpdating: PropTypes.bool.isRequired,
  match: PropTypes.shape({
    params: PropTypes.shape({
      id: PropTypes.string,
    }),
  }).isRequired,
}

export default connect(
  state => updateLiveFormSelector(state), {
    dispatchUpdateLive: updateLive,
    dispatchLoadLive: loadLive,
    dispatchClearLoadedLive: clearLoadedLive,
  })(LivesUpdate)
