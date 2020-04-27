const sportFilterSelector = state => ({
  filterProperty: state.sports.options.filter.property,
  filterQuery: state.sports.options.filter.query,
})

const sportTableSelector = state => ({
  entries: state.sports.entries,
  loaded: state.sports.loaded,
  sortColumn: state.sports.options.sort.column,
  sortDirection: state.sports.options.sort.direction,
  currentPage: state.sports.options.currentPage,
  pageCount: state.sports.options.pageCount,
})

export { sportFilterSelector, sportTableSelector }
