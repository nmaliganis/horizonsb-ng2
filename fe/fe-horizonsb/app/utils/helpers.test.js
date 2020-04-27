import {
  range,
  parseDate,
  dateFormatUS,
  dateFormatIntl,
  getWeekRange,
  getMonthRange,
  formatWeight,
  formatHeight,
  formatNumber,
  areRangesEqual,
} from './helpers'

describe('range', () => {
  it('produces valid zero-based range', () => {
    expect(range(0, 3)).toEqual([0, 1, 2])
  })

  it('produces valid non-zero-based range', () => {
    expect(range(5, 8)).toEqual([5, 6, 7])
  })
})

describe('dateParser', () => {
  it('returns null for empty date', () => {
    expect(parseDate('')).toEqual(undefined)
  })

  it('returns null for incomplete date', () => {
    expect(parseDate('01/01/')).toEqual(undefined)
  })

  it('returns null for invalid date', () => {
    expect(parseDate('13/01/2018')).toEqual(undefined)
  })

  it('parses valid date', () => {
    const expected = new Date(2018, 2, 22)
    expect(parseDate('03/22/2018')).toEqual(expected)
  })
})

describe('dateFormatUS', () => {
  it('formats date in US format', () => {
    expect(dateFormatUS(new Date(2018, 2, 22))).toEqual('03/22/2018')
  })

  it('accepts date as a string', () => {
    expect(dateFormatUS('2018-03-22T16:43:04.831Z')).toEqual('03/22/2018')
  })

  it('returns null for null date', () => {
    expect(dateFormatUS(null)).toEqual(null)
  })
})

describe('dateFormatIntl', () => {
  it('formats date in international format', () => {
    expect(dateFormatIntl(new Date(2018, 2, 22))).toEqual('2018-03-22')
  })

  it('accepts date as a string', () => {
    expect(dateFormatIntl('2018-03-22T16:43:04.831Z')).toEqual('2018-03-22')
  })

  it('returns null for null date', () => {
    expect(dateFormatIntl(null)).toEqual(null)
  })
})

describe('getWeekRange', () => {
  it('returns valid range', () => {
    const expected = {
      from: new Date(2018, 2, 18),
      to: new Date(2018, 2, 24),
    }
    expect(getWeekRange(new Date(2018, 2, 22))).toEqual(expected)
  })

  it('discards time from dates', () => {
    const expected = {
      from: new Date(2018, 2, 18),
      to: new Date(2018, 2, 24),
    }
    expect(getWeekRange(new Date(2018, 2, 22, 5, 5, 5, 5))).toEqual(expected)
  })
})

describe('getMonthRange', () => {
  it('returns valid range', () => {
    const expected = {
      from: new Date(2018, 2, 1),
      to: new Date(2018, 2, 31),
    }
    expect(getMonthRange(new Date(2018, 2, 22))).toEqual(expected)
  })
})

describe('formatWeight', () => {
  it('converts kgs to lbs', () => {
    expect(formatWeight(108)).toEqual('238 lbs')
  })

  it('works with null argument', () => {
    expect(formatWeight(null)).toEqual(null)
  })
})

describe('formatHeight', () => {
  it('converts cm to feet and inches', () => {
    expect(formatHeight(200)).toEqual("6'7'")
  })

  it('works with null argument', () => {
    expect(formatHeight(null)).toEqual(null)
  })
})

describe('formatNumber', () => {
  it('works with numbers that have fewer than 3 digits', () => {
    expect(formatNumber(25)).toEqual('25')
  })

  it('works with numbers that have 3 digits', () => {
    expect(formatNumber(123)).toEqual('123')
  })

  it('works with numbers that have more than 3 digits', () => {
    expect(formatNumber(123456)).toEqual('123,456')
  })

  it('works with numbers that have more than 6 digits', () => {
    expect(formatNumber(1234567)).toEqual('1,234,567')
  })
})

describe('areRangesEqual', () => {
  it('returns true for equal ranges', () => {
    const rangeA = { from: new Date(2018, 2, 1), to: new Date(2018, 2, 22) }
    const rangeB = { from: new Date(2018, 2, 1), to: new Date(2018, 2, 22) }
    expect(areRangesEqual(rangeA, rangeB)).toEqual(true)
  })

  it('returns false for different ranges', () => {
    const rangeA = { from: new Date(2018, 2, 1), to: new Date(2018, 2, 22) }
    const rangeB = { from: new Date(2018, 2, 2), to: new Date(2018, 2, 22) }
    expect(areRangesEqual(rangeA, rangeB)).toEqual(false)
  })

  it('returns true for empty ranges', () => {
    const rangeA = { from: null, to: null }
    const rangeB = { from: null, to: null }
    expect(areRangesEqual(rangeA, rangeB)).toEqual(true)
  })
})
