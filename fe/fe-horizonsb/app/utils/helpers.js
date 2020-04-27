import moment from 'moment-timezone/builds/moment-timezone-with-data'
import format from 'date-fns/format'
import parseISO from 'date-fns/parseISO'

const range = (start, stop) =>
  Array(stop - start)
  .fill(start)
  .map((x, y) => x + y)

const parseDate = dateString => {
  const matches = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/.exec(dateString)

  if (matches !== null && matches.length === 4) {
    const day = parseInt(matches[2])
    const month = parseInt(matches[1]) - 1
    const year = parseInt(matches[3])

    const composedDate = new Date(year, month, day)

    if (
      composedDate.getDate() === day &&
      composedDate.getMonth() === month &&
      composedDate.getFullYear() === year
    ) {
      return composedDate
    }
  }
  return null || undefined
}

const formatDate = (dateObj, formatString) => {
  if (dateObj) {
    if (typeof dateObj === 'string') {
      return format(parseISO(dateObj), formatString)
    }
    return format(dateObj, formatString)
  }
  return null
}

const dateAsUTC = (date) => new Date(
  Date.UTC(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds())
)

const dateToUTC = (date) => new Date(
  date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate(), date.getUTCHours(), date.getUTCMinutes(), date.getUTCSeconds()
)

const dateFormatUS = dateObj => moment(dateObj).format('MM/DD/YYYY')

const dateTimeFormatUS = dateObj => moment(dateObj).format('MM/DD/YYYY hh:mm:ss A')

const dateFormatIntl = dateObj => formatDate(dateObj, 'yyyy-MM-dd')

const formatWeight = weight => weight && `${(weight * 2.2046).toFixed(0)} lbs`

const formatHeight = height => {
  if (height) {
    const feet = Math.floor(height / 30.48)
    const inches = Math.round((height - feet * 30.48) / 2.54)

    return `${feet}'${inches}'`
  }
  return null
}

const formatNumber = number => number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")

const getWeekRange = (currentDate = new Date()) => {
  const from = currentDate.getDate() - currentDate.getDay()
  const to = from + 6

  const fromDate = new Date(currentDate.setDate(from)).setHours(0, 0, 0, 0)
  const toDate = new Date(currentDate.setDate(to)).setHours(0, 0, 0, 0)

  return {
    from: new Date(fromDate),
    to: new Date(toDate),
  }
}

const getMonthRange = (currentDate = new Date()) => {
  const fromDate = new Date(
    currentDate.getFullYear(),
    currentDate.getMonth(),
    1
  )
  const toDate = new Date(
    currentDate.getFullYear(),
    currentDate.getMonth() + 1,
    0
  )

  return {
    from: fromDate,
    to: toDate,
  }
}

const areRangesEqual = (rangeA, rangeB) => {
  if (rangeA && rangeB) {
    if (rangeA.from && rangeB.from && rangeA.to && rangeB.to) {
      return (
        rangeA.from.getTime() === rangeB.from.getTime() &&
        rangeA.to.getTime() === rangeB.to.getTime()
      )
    }
    return rangeA.from === rangeB.from && rangeA.to === rangeB.to
  }
  return rangeA === rangeB
}

 export const removeTimezoneNormal = date => new Date(moment(date).format('YYYY-MM-DDTHH:mm:SS'))

export {
  range,
  parseDate,
  dateFormatUS,
  dateTimeFormatUS,
  dateFormatIntl,
  getWeekRange,
  getMonthRange,
  formatWeight,
  formatHeight,
  formatNumber,
  areRangesEqual,
}
