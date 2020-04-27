const filterSelector = state => ({
  currentRange: state.summary.currentRange,
})

const tournamentSummarySelector = state => ({
  currentRange: state.summary.currentRange,
  loaded: state.summary.tournament.loaded,
  data: state.summary.tournament.data,
})

const eventSummarySelector = state => ({
  currentRange: state.summary.currentRange,
  loaded: state.summary.event.loaded,
  data: state.summary.event.data,
})

const marketSummarySelector = state => ({
  currentRange: state.summary.currentRange,
  loaded: state.summary.market.loaded,
  data: state.summary.market.data,
})

const liveSummarySelector = state => ({
  currentRange: state.summary.currentRange,
  loaded: state.summary.live.loaded,
  data: state.summary.live.data,
})


const sportSummarySelector = state => ({
  currentRange: state.summary.currentRange,
  loaded: state.summary.sport.loaded,
  data: state.summary.sport.data,
})

export {
  tournamentSummarySelector,
  liveSummarySelector,
  sportSummarySelector,
  eventSummarySelector,
  marketSummarySelector,
  filterSelector,
}
