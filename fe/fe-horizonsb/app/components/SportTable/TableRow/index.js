import React, { Component } from 'react'
import PropTypes from 'prop-types'

import {
  RowContainer,
  Head,
  Body,
  ActionBox,
  ViewButton,
  CloseButton,
  WideLabel,
  NormalLabel,
} from './styled'
import { ContentColumn, ContentLabel, ContentRow, EditButton } from '../../Table/TableRow/styled'
import { Link } from 'react-router-dom'

class TableRow extends Component {
  constructor(props) {
    super(props)
    this.state = {
      isOpen: false,
    }
  }

  toggleState = () => {
    this.setState({
      ...this.state,
      isOpen: !this.state.isOpen })
  }


  render() {
    const {
      id,
      name,
      sportId,
      priority,
      numEvents,
    } = this.props

    return (
      <RowContainer isOpen={this.state.isOpen}>
        <Head>
          <WideLabel>{name}</WideLabel>
          <NormalLabel>{sportId}</NormalLabel>
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
              <Link to={`/sports/update/${id}`}>
                <EditButton label="update sport" />
              </Link>
            </ContentColumn>
          </ContentRow>
          </Body>
        )}
      </RowContainer>
    )
  }
}

TableRow.defaultProps = {
  sportId: '',
  name: '',
  priority: 1,
  numEvents: 0,
}

TableRow.propTypes = {
  id: PropTypes.string.isRequired,
  sportId: PropTypes.string.isRequired,
  name: PropTypes.string,
  priority: PropTypes.number,
  numEvents: PropTypes.number,
}

export default TableRow
