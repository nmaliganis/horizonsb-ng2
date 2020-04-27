import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'
import {
  RowContainer,
  Head,
  Body,
  Label,
  WideLabel,
  ActionBox,
  NormalLabel,
  ViewButton,
  CloseButton,
  EditButton,
  ContentRow,
  ContentColumn,
  ContentLabel,
} from '../../Table/TableRow/styled'
import { DescriptionColumn } from './styled'
import { dateTimeFormatUS, removeTimezoneNormal } from '../../../utils/helpers'

class FavoriteTableRow extends Component {
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
      livePriority,
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
          </ActionBox>
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
                <Link to={`/favorites/update/${id}`}>
                  <EditButton label="update favorite" />
                </Link>
              </ContentColumn>
            </ContentRow>
          </Body>
        )}
      </RowContainer>
    )
  }
}

FavoriteTableRow.defaultProps = {
  eventId: '',
  name: '',
  livePriority: 1,
  eventSportName: '',
  eventTournamentName: '',
  numberOfMarkets: 0,
  favorite: false,
}

FavoriteTableRow.propTypes = {
  eventId: PropTypes.string.isRequired,
  id: PropTypes.string.isRequired,
  name: PropTypes.string,
  livePriority: PropTypes.number.isRequired,
  eventSportName: PropTypes.string.isRequired,
  eventTournamentName: PropTypes.string.isRequired,
  numberOfMarkets: PropTypes.number.isRequired,
  favorite: PropTypes.bool.isRequired,
}

export default FavoriteTableRow
