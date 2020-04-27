import React from 'react'
import { LogoWrapper, LogoLabel } from './styled'
import { LogoIcon } from '../../assets/icons'

const  LogoWithLabel = () => (
  <LogoWrapper to="/">
    {/*<LogoIcon />*/}
    <LogoLabel>admin</LogoLabel>
  </LogoWrapper>
)

export default LogoWithLabel
