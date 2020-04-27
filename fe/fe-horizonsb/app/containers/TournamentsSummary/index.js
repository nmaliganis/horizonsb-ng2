import React, { Component, Fragment } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Panel, PanelItem } from '../../components/Panel'
import { getTournamentSummary } from '../../actions/summary'
import { tournamentSummarySelector } from '../../selectors/summary'

class TournamentsSummary extends Component {
  componentDidMount() {
    if (!this.props.loaded) {
      this.props.getTournamentSummary()
    }
  }

  render() {
    const { totalCount, priorityCount } = this.props.data

    return (
      <Fragment>
        <h2>Tournaments</h2>
        <Panel>
          <PanelItem title="Total" value={totalCount} />
          <PanelItem
            title="Prioritized"
            value={priorityCount}
          />
        </Panel>
      </Fragment>
    )
  }
}


TournamentsSummary.propTypes = {
  data: PropTypes.object.isRequired,
  getTournamentSummary: PropTypes.func.isRequired,
  loaded: PropTypes.bool.isRequired,
}

export default connect(state => tournamentSummarySelector(state), {
  getTournamentSummary: getTournamentSummary,
})(TournamentsSummary)
