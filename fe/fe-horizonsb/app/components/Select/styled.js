import styled from 'styled-components'
import Select from 'react-select'
import { color, fontSize } from 'styles/variables'
import mq from 'styles/mq'
import 'libs/react-select/dist/react-select.css'

export const StyledSelect = styled(Select)`
  .Select-control {
    border: 1px solid #d8d8d8;
    height: 40px;
    font-size: ${fontSize.default};
    margin: 15px 0;

    ${mq.phone`
      margin-bottom: 0;
    `};
  }

  .Select-placeholder {
    line-height: 40px;
    color: ${color.darkGray};
  }

  .Select-value-label {
    line-height: 40px;
  }

  .Select-option {
    font-size: ${fontSize.default};
    line-height: 1.6;
    color: ${color.darkGray};
  }

  .Select-clear {
    vertical-align: text-bottom;
  }
`
