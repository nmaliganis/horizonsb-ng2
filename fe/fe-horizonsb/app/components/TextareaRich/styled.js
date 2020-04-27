import styled from 'styled-components'
import ReactQuill from 'react-quill'

export const StyledReactQuill = styled(ReactQuill)`
  margin: 15px 0;
  
  .ql-editor {
    min-height: 350px;
    border-radius: 4px;
    font-family: nexa, 'Helvetica','Arial', sans-serif;
  }
  
  .ql-editor.ql-blank::before {
    font-style: normal;
    color: #969696;
    font-size: 14px;
    line-height: 25px;
  }
  
  .ql-container {
    border-bottom-left-radius: 4px;
    border-bottom-right-radius: 4px;
  }
  
  .ql-toolbar {
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
  }
`

export const CharacterLimit = styled.span`
  display: block;
  color: #969696;
  font-size: 12px;
  margin-top: 5px;
`
