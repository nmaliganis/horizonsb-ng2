import styled from 'styled-components'
import mq from '../../styles/mq'
import { font, color } from '../../styles/variables'

export const Container = styled.div`
  margin-bottom: 15px;

  input {
    border: 1px solid #ddd;
    margin-top: 15px;
    border-radius: 3px;

    &:focus {
      outline: none;
    }

    ${mq.phone`
      max-width: 130px;
    `};
  }

  .react-datepicker {
    font-family: ${font.nexa};
    border-color: ${color.mediumGray};
  }

  .react-datepicker__time-container {
    border-left-color: ${color.mediumGray};
    width: 90px;

    .react-datepicker__time {
      .react-datepicker__time-box {
        width: 90px;
      }
    }
  }

  .react-datepicker__navigation--next--with-time:not(.react-datepicker__navigation--next--with-today-button) {
    right: 100px;
  }

  .react-datepicker__day-name {
    width: 2rem;
    line-height: 2rem;
    color: ${color.muted};
  }

  .react-datepicker__navigation {
    top: 20px;
  }

  .react-datepicker__current-month {
    padding: 10px 0;
  }

  .react-datepicker__day,
  .react-datepicker__day--selected {
    width: 2rem;
    line-height: 2rem;
    border-radius: 1rem;

    &:hover {
      border-radius: 1rem;
    }
  }

  .react-datepicker__triangle {
    display: none;
  }

  .react-datepicker__day--keyboard-selected {
    border-radius: 1rem;
  }

  .react-datepicker__header {
    background: none;
    border-bottom: none;
  }
`
