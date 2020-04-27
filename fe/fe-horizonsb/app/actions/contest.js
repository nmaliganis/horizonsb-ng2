import { createActionSet } from 'utils/actionHelper'

const CONTEST_SUMMARY = createActionSet('contest')
const LATEST_SUMMARY = createActionSet('latest-summary')

const postContest = payload => ({
  type: CONTEST_SUMMARY.PENDING,
  payload,
})

const postContestSuccess = payload => ({
  type: CONTEST_SUMMARY.SUCCESS,
  payload,
})

const postContestError = message => ({
  type: CONTEST_SUMMARY.ERROR,
  payload: message,
})

const getLatestSummary = () => ({
  type: LATEST_SUMMARY.PENDING,
})

const getLatestSummarySuccess = payload => ({
  type: LATEST_SUMMARY.SUCCESS,
  payload,
})

const getLatestSummaryError = message => ({
  type: LATEST_SUMMARY.ERROR,
  payload: message,
})

export {
  LATEST_SUMMARY,
  CONTEST_SUMMARY,
  postContest,
  postContestSuccess,
  postContestError,
  getLatestSummary,
  getLatestSummarySuccess,
  getLatestSummaryError,
}
