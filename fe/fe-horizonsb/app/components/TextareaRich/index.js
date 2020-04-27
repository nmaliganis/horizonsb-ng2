import React, { Fragment } from 'react'
import PropTypes from 'prop-types'
import {
  Label,
  Error,
} from '../Form/styled'
import {
  StyledReactQuill,
  CharacterLimit,
} from './styled'
import { stripAll } from '../../utils/sanitizeHtml'
import 'react-quill/dist/quill.snow.css'

const modules = {
  toolbar: [
    ['bold', 'italic', 'underline'],
    ['link'],
    ['clean'],
  ],
}

const formats = [
  'header',
  'bold', 'italic', 'underline', 'strike', 'blockquote',
  'list', 'bullet', 'indent',
  'link', 'image',
]

const TextareaRich = ({ error, label, maxLength, ...textareaProps }) => (
  <Fragment>
    {label && (
      <Fragment>
        <Label>{label}</Label>
        {maxLength !== null &&
        <CharacterLimit>{maxLength - stripAll(textareaProps.value).length} of {maxLength} characters left</CharacterLimit>
        }
      </Fragment>
    )}
    <StyledReactQuill
      modules={modules}
      formats={formats}
      {...textareaProps}
    />
    {error && (
      <Error>{error}</Error>
    )}
  </Fragment>
)

TextareaRich.defaultProps = {
  error: null,
  label: null,
  maxLength: null,
}

TextareaRich.propTypes = {
  error: PropTypes.string,
  label: PropTypes.string,
  maxLength: PropTypes.number,
}

export default TextareaRich
