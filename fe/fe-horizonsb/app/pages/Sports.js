import React, { Fragment } from 'react'
import Nav from '../components/Nav'
import SportFilter from '../containers/SportFilter'
import Container from '../components/Container'
import Column from '../components/Column'
import SportTable from '../containers/SportTable'
import ErrorMessage from '../containers/ErrorMessage'

const Sports = () => (
  <Fragment>
    <Nav />
    <SportFilter />
    <ErrorMessage />
    <Container>
      <Column width={100}>
        <SportTable />
      </Column>
    </Container>
  </Fragment>
)

export default Sports
