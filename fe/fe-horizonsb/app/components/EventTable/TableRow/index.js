import React, { Component, Fragment } from 'react'
import { Link } from 'react-router-dom'
import { path } from 'ramda'
import PropTypes from 'prop-types'
import {
  RowContainer,
  Head,
  Body,
  WideLabel,
  NormalLabel,
  ActionBox,
  ViewButton,
  CloseButton,
  Label,
  ContentRow,
  ContentColumn,
  ContentLabel,
  EditButton,
} from '../../Table/TableRow/styled'
import { DescriptionColumn } from './styled'
import { dateTimeFormatUS, removeTimezoneNormal } from '../../../utils/helpers'

class EventTableRow extends Component {
  constructor(props) {
    super(props)
    this.state = {
      isOpen: false,
    }
  }

  toggleState = () => {
    this.setState({
      ...this.state,
      isOpen: !this.state.isOpen,
    })
  }

  render() {
    const {
      id,
      name,
      eventId,
      dateEvent,
      priority,
      eventSportName,
      eventTournamentName,
      description,
      favorite,
    } = this.props

    return (
      <RowContainer isOpen={this.state.isOpen}>
        <Head>
          <WideLabel>{name}</WideLabel>
          <NormalLabel>{eventId}</NormalLabel>
          <NormalLabel>{priority}</NormalLabel>
          <NormalLabel>{eventSportName}</NormalLabel>
          <NormalLabel>{eventTournamentName}</NormalLabel>
          <NormalLabel>
            {
              dateTimeFormatUS(removeTimezoneNormal(dateEvent))
            }
          </NormalLabel>
          <ActionBox>
            {this.state.isOpen ? (
              <CloseButton onClick={this.toggleState} />
            ) : (
              <ViewButton onClick={this.toggleState} />
            )}
          </ActionBox><title>Events Table</title>
        </Head>
        {this.state.isOpen && (
          <Body>
          <ContentRow>
            <DescriptionColumn>
              <Label>Description</Label>
              <div>{description}</div>
            </DescriptionColumn>
            <DescriptionColumn>
              <Label>Favorite</Label>
              {favorite ? (
                <div>Yes</div>
              ) : (
                <div>No</div>
              )}
            </DescriptionColumn>
          </ContentRow>
          <ContentRow>
            <ContentColumn>
              <ContentLabel>Available Actions</ContentLabel>
              <Link to={`/events/update/${id}`}>
                <EditButton label="update event" />
              </Link>
            </ContentColumn>
          </ContentRow>
          </Body>
        )}
      </RowContainer>
    )
  }
}

EventTableRow.defaultProps = {
  eventId: '',
  name: '',
  priority: 1,
  eventSportName: '',
  eventTournamentName: '',
  numberOfMarkets: 0,
  favorite: false,
}

EventTableRow.propTypes = {
  eventId: PropTypes.string.isRequired,
  id: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  eventSportName: PropTypes.string.isRequired,
  eventTournamentName: PropTypes.string.isRequired,
  priority: PropTypes.number.isRequired,
  numberOfMarkets: PropTypes.number.isRequired,
  favorite: PropTypes.bool.isRequired,
}

export default EventTableRow
