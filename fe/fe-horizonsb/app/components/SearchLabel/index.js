import React from 'react'
import PropTypes from 'prop-types'
import { Container, ResetButton } from './styled'

const SearchLabel = ({ property, query, onReset }) =>
  (property &&
    query && (
      <Container>
        <span>
          {property.label}: {query}
        </span>
        <ResetButton onClick={onReset} />
      </Container>
    )) ||
  null

SearchLabel.propTypes = {
  onReset: PropTypes.func.isRequired,
  property: PropTypes.shape({
    label: PropTypes.string.isRequired,
  }),
  query: PropTypes.string,
}

export default SearchLabel
