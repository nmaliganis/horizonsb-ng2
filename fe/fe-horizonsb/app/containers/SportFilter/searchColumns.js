const searchColumnDefs = {
  name: {
    label: 'Name',
    placeholder: 'Search By Name',
    formatter(val) {
      return val
    },
  },
  sportId: {
    label: 'SportID',
    placeholder: 'Search By SportID',
    formatter(val) {
      return val
    },
  },
  priorityHigher: {
    label: 'Priority >=',
    placeholder: 'Search By Priority >=',
    formatter(val) {
      return val
    },
  },
  priorityLower: {
    label: 'Priority =<',
    placeholder: 'Search By Priority =<',
    formatter(val) {
      return val
    },
  },
}

const filterOptions = Object.keys(searchColumnDefs).map(column => ({
  value: column,
  label: searchColumnDefs[column].label,
}))

export { searchColumnDefs, filterOptions }
