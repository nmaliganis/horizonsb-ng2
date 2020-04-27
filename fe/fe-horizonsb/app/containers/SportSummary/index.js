import React, { Fragment, Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { Panel, PanelItem } from '../../components/Panel'
import { getSportSummary } from '../../actions/summary'
import { sportSummarySelector } from '../../selectors/summary'

class SportsSummary extends Component {
  componentDidMount() {
    if (!this.props.loaded) {
      this.props.getSportSummary()
    }
  }

  render() {
    const { totalCount, priorityCount } = this.props.data

    return (
      <Fragment>
        <h2>Sports</h2>
        <Panel>
          <PanelItem title={'Total'} value={totalCount} />
          <PanelItem
            title={'Prioritized'}
            value={priorityCount}
          />
        </Panel>
      </Fragment>
    )
  }
}


SportsSummary.propTypes = {
  data: PropTypes.object.isRequired,
  getSportSummary: PropTypes.func.isRequired,
  loaded: PropTypes.bool.isRequired,
}

export default connect(state => sportSummarySelector(state), {
  getSportSummary: getSportSummary,
})(SportsSummary)
