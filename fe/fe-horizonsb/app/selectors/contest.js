const selectContestDataAsCSV = state => {
  if (state.contest.data) {
    const csvContent = `data:text/csv;charset=utf-8,${state.contest.data.csv}`
    const encodedUri = encodeURI(csvContent)
    return encodedUri
  }
  return state.contest.data
}

const selectLatestSummaryAsCSV = state => {
  if (state.contest.summary) {
    const csvContent = `data:text/csv;charset=utf-8,${state.contest.summary}`
    const encodedUri = encodeURI(csvContent)
    return encodedUri
  }
  return state.contest.summary
}

const selectConstestPostError = state => state.contest.error

const selectConstestPostLoading = state => state.contest.loading
const selectLatestSummaryLoad = state => state.contest.summaryLoading

export {
  selectContestDataAsCSV,
  selectConstestPostError,
  selectConstestPostLoading,
  selectLatestSummaryAsCSV,
  selectLatestSummaryLoad,
}
