import GoogleLogin from 'react-google-login'
import styled from 'styled-components'
import mq from '../../styles/mq'
import { color, font, fontSize } from '../../styles/variables'

export const LoginButton = styled(GoogleLogin)`
  background-color: ${color.orange};
  padding: 15px 20px;
  color: white;
  border: none;
  text-transform: uppercase;
  font-family: ${font.riftSoft}, sans-serif;
  font-size: ${fontSize.default};
  font-weight: ${font.bold};
  letter-spacing: 1px;
  line-height: 17px;
  height: 55px;
  margin-top: 25px;
  min-width: 360px;
  border-radius: 4px;
  box-shadow: 0 2px 18px 0 rgba(146, 146, 146, 0);

  ${mq.phone`
    min-width: 100%;
  `};
`
