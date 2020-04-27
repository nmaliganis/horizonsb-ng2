import React from 'react'
import { Container, SearchIcon } from './styled'

const SearchBox = props => (
  <Container>
    <SearchIcon />
    <input type="text" {...props} />
  </Container>
)

export default SearchBox
