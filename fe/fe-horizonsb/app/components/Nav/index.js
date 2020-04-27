import React from 'react'
import Logo from "../Logo"
import Container from "../Container"
import Column from "../Column"
import LinkItem from './LInkItem'
import UserDropdown from './UserDropdown'
import { Panel, Navigation, LogoContainer } from './styled'

const Nav = () => (
  <Panel>
    <Container>
      <Column width={100}>
        <LogoContainer>
          <Logo />
        </LogoContainer>
        <Navigation>
          <LinkItem href="/dashboard" label="Dashboard" />
          <LinkItem href="/sports" label="Sports" />
          <LinkItem href="/tournaments" label="Tournaments" />
          <LinkItem href="/events" label="Events" />
          <LinkItem href="/lives" label="Lives" />
          <LinkItem href="/favorites" label="Favorites" />
        </Navigation>
        <UserDropdown />
      </Column>
    </Container>
  </Panel>
)

export default Nav
