import React, { Component, Fragment } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Panel, PanelItem } from '../../components/Panel'
import { getEventSummary } from '../../actions/summary'
import { eventSummarySelector } from '../../selectors/summary'

class EventsSummary extends Component {
  componentDidMount() {
    if (!this.props.loaded) {
      this.props.getEventSummary()
    }
  }

  render() {
    const { totalCount, priorityCount, favoriteCount} = this.props.data

    return (
      <Fragment>
        <h2>Events</h2>
        <Panel>
          <PanelItem
            title="Total"
            value={totalCount}
          />
          <PanelItem
            title="Prioritized"
            value={priorityCount}
          />
         <PanelItem
            title="Favorites"
            value={favoriteCount}
          />
        </Panel>
      </Fragment>
    )
  }
}

EventsSummary.propTypes = {
  data: PropTypes.object.isRequired,
  getEventSummary: PropTypes.func.isRequired,
  loaded: PropTypes.bool.isRequired,
}

export default connect(state => eventSummarySelector(state), {
  getEventSummary: getEventSummary,
})(EventsSummary)
