import React, { Component, Fragment } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Panel, PanelItem } from '../../components/Panel'
import { getMarketSummary } from '../../actions/summary'
import { marketSummarySelector } from '../../selectors/summary'

class MarketsSummary extends Component {
  componentDidMount() {
    if (!this.props.loaded) {
      this.props.getMarketSummary()
    }
  }

  render() {
    const { totalMarketCount, totalOddCount} = this.props.data

    return (
      <Fragment>
        <h2>Markets</h2>
        <Panel>
          <PanelItem
            title="Total"
            value={totalMarketCount}
          />
          <PanelItem
            title="Odds"
            value={totalOddCount}
          />
        </Panel>
      </Fragment>
    )
  }
}

MarketsSummary.propTypes = {
  data: PropTypes.object.isRequired,
  getMarketSummary: PropTypes.func.isRequired,
  loaded: PropTypes.bool.isRequired,
}

export default connect(state => marketSummarySelector(state), {
  getMarketSummary: getMarketSummary,
})(MarketsSummary)
