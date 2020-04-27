import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'
import {
  RowContainer,
  Head,
  Body,
  WideLabel,
  NormalLabel,
  ActionBox,
  ViewButton,
  CloseButton,
  EditButton,
  ContentRow,
  ContentColumn,
  ContentLabel,
} from '../../Table/TableRow/styled'

class TournamentTableRow extends Component {
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
      tournamentId,
      priority,
      numEvents,
    } = this.props

    return (
      <RowContainer isOpen={this.state.isOpen}>
        <Head>
          <WideLabel>{name}</WideLabel>
          <NormalLabel>{tournamentId}</NormalLabel>
          <NormalLabel>{priority}</NormalLabel>
          <NormalLabel>{numEvents}</NormalLabel>
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
              <ContentColumn>
                <ContentLabel>Available Actions</ContentLabel>
                <Link to={`/tournaments/update/${id}`}>
                  <EditButton label="update tournament" />
                </Link>
              </ContentColumn>
            </ContentRow>
          </Body>
        )}
      </RowContainer>
    )
  }
}

TournamentTableRow.defaultProps = {
  tournamentId: '',
  name: '',
  priority: 1,
  numEvents: 0,
}

TournamentTableRow.propTypes = {
  id: PropTypes.string.isRequired,
  tournamentId: PropTypes.string.isRequired,
  name: PropTypes.string,
  priority: PropTypes.number.isRequired,
  numEvents: PropTypes.number,
}

export default TournamentTableRow
