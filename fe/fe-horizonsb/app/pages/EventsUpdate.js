import React, { Fragment, useEffect } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import EventForm from '../forms/Event'
import { EVENTS_MENU_ITEMS } from '../constants'
import Nav from '../components/Nav'
import Container from '../components/Container'
import EventsMenu from '../components/Menu'
import Content from '../components/Content'
import Column from '../components/Column'
import useRouter from '../hooks/userRouter'
import { updateEventFormSelector } from '../selectors/updateEventForm'
import { updateEvent, loadEvent, clearLoadedEvent } from '../actions/events'
import ErrorMessage from '../containers/ErrorMessage'

const getMenuItems =
  id => [
    ...EVENTS_MENU_ITEMS,
    {
      label: 'Update Event',
      to: `/events/update/${id}`,
    },
  ]

const EventsUpdate = ({ isUpdating, entry, dispatchUpdateEvent, dispatchClearLoadedEvent, dispatchLoadEvent }) => {
  const { match } = useRouter()

  useEffect(() => {
    dispatchLoadEvent(match.params.id)

    return function cleanup() {
      dispatchClearLoadedEvent()
    }
  }, [])

  return (
    <Fragment>
      <Nav />
      <EventsMenu menuItems={getMenuItems(match.params.id)} />
      <ErrorMessage />
      <Container isColumn>
        <Column width={100}>
          <h2>Update Event</h2>
          <Content isColumn>
            {entry && <EventForm isLoading={isUpdating} submit={dispatchUpdateEvent} initial={entry} />}
          </Content>
        </Column>
      </Container>
    </Fragment>
  )
}

EventsUpdate.defaultProps = {
  entry: null,
}

EventsUpdate.propTypes = {
  dispatchClearLoadedEvent: PropTypes.func.isRequired,
  dispatchLoadEvent: PropTypes.func.isRequired,
  dispatchUpdateEvent: PropTypes.func.isRequired,
  entry: PropTypes.shape({
    eventId: PropTypes.string,
    description: PropTypes.string,
    dateEvent: PropTypes.string,
    id: PropTypes.string,
    name: PropTypes.string,
    priority: PropTypes.number,
    numberOfMarkets: PropTypes.number,
    favorite: PropTypes.bool,
  }),
  isUpdating: PropTypes.bool.isRequired,
}

export default connect(state => updateEventFormSelector(state), {
  dispatchUpdateEvent: updateEvent,
  dispatchLoadEvent: loadEvent,
  dispatchClearLoadedEvent: clearLoadedEvent,
})(EventsUpdate)
