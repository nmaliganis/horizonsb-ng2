import styled from 'styled-components'
import { color } from 'styles/variables'

export const TableContainer = styled.section`
  margin-bottom: 25px;
`

export const EmptyRow = styled.div`
  border-bottom: 1px solid ${color.mediumGray};
  background-color: #fff;
  border-left: 1px solid ${color.mediumGray};
  border-right: 1px solid ${color.mediumGray};
  text-align: center;
  padding: 20px;
`
