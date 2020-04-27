import React, { Component, Fragment } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Panel, PanelItem } from '../../components/Panel'
import { getLiveSummary } from '../../actions/summary'
import { liveSummarySelector } from '../../selectors/summary'

class LivesSummary extends Component {
  componentDidMount() {
    if (!this.props.loaded) {
      this.props.getLiveSummary()
    }
  }

  render() {
    const { totalLiveCount, totalLivePriorityCount} = this.props.data

    return (
      <Fragment>
        <h2>Lives</h2>
        <Panel>
          <PanelItem
            title="TOTAL"
            value={totalLiveCount}
          />
          <PanelItem
            title="PRIORITIZED"
            value={totalLivePriorityCount}
          />
        </Panel>
      </Fragment>
    )
  }
}

LivesSummary.propTypes = {
  data: PropTypes.object.isRequired,
  getLiveSummary: PropTypes.func.isRequired,
  loaded: PropTypes.bool.isRequired,
}

export default connect(state => liveSummarySelector(state), {
  getLiveSummary: getLiveSummary,
})(LivesSummary)
