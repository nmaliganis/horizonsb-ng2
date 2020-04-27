import React from 'react'
import { Link } from 'react-router-dom'
import { Container } from './styled'

const UserDropdown = () => (
  <Container>
    <Link to="/signout">Sign out</Link>
  </Container>
)

export default UserDropdown
