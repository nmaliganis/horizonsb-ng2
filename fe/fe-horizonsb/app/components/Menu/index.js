import React from 'react'
import PropTypes from 'prop-types'
import Column from "../Column"
import Container from "../Container"
import { Panel } from './styled'
import Item from './Item'

const Menu = ({ menuItems }) => (
  <Panel>
    <Container>
      <Column width={100}>
        {menuItems.map((item, index) => (
          <Item
            label={item.label}
            key={item.to}
            to={item.to}
            isActive={index === 0}
          />
        ))}
      </Column>
    </Container>
  </Panel>
)


Menu.propTypes = {
  menuItems: PropTypes.arrayOf(PropTypes.shape({
    label: PropTypes.string.isRequired,
    to: PropTypes.string.isRequired,
  })).isRequired,
}

export default Menu
