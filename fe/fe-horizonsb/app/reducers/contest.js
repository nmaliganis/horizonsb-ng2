import { CONTEST_SUMMARY, LATEST_SUMMARY } from '../actions/contest'

const defaultState = {
  data: null,
  loading: false,
  error: null,
  summary: null,
  summaryLoading: false,
}

const contestReducer = (state = defaultState, action) => {
  switch (action.type) {
    case CONTEST_SUMMARY.PENDING:
      return { data: null, error: null, loading: true, summary: state.summary }
    case CONTEST_SUMMARY.SUCCESS:
      return {
        data: action.payload,
        error: null,
        loading: false,
        summary: state.summary,
      }
    case CONTEST_SUMMARY.ERROR:
      return {
        data: null,
        error: action.payload,
        loading: false,
        summary: state.summary,
      }
    case LATEST_SUMMARY.PENDING:
      return {
        summary: null,
        error: null,
        summaryLoading: true,
      }
    case LATEST_SUMMARY.SUCCESS:
      return {
        summary: action.payload,
        error: null,
        summaryLoading: false,
      }
    case LATEST_SUMMARY.ERROR:
      return {
        summary: null,
        error: action.payload,
        summaryLoading: false,
      }
    default:
      return state
  }
}

export default contestReducer
