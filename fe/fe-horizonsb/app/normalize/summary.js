import {
  compose,
} from 'ramda'

export const normalizeRetrievedData = (dataTotal, dataPriority, datFavorite) => compose(
  item => ({
    ...item,
    totalCount : dataTotal,
    priorityCount : dataPriority,
    favoriteCount : datFavorite,
  })
)(dataTotal, dataPriority, datFavorite)

export const normalizeRetrievedMarketData = (dataMarket, dataOdd) => compose(
  item => ({
    ...item,
    totalMarketCount : dataMarket,
    totalOddCount : dataOdd,
  })
)(dataMarket, dataOdd)


export const normalizeRetrievedLiveData = (dataLive, dataLivePriority) => compose(
  item => ({
    ...item,
    totalLiveCount : dataLive,
    totalLivePriorityCount : dataLivePriority,
  })
)(dataLive, dataLivePriority)
