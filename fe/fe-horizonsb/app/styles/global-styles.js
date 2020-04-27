import { injectGlobal } from 'styled-components'

import { color, font, fontSize } from './variables'

const riftSoftBold = '/RiftSoft-Bold.otf'
const nexaRegular = '/Nexa-Regular.ttf'
const nexaBold = '/Nexa-XBold.ttf'

/* eslint-disable no-unused-expressions */
injectGlobal`

  @font-face {
    font-family: ${font.riftSoft};
    src: url(${riftSoftBold}) format('opentype');
    font-weight: ${font.bold};
    font-style: normal;
  }

  @font-face {
    font-family: ${font.nexa};
    src: url(${nexaRegular}) format('truetype');
  }

  @font-face {
    font-family: ${font.nexa};
    src: url(${nexaBold}) format('truetype');
    font-weight: ${font.bold};
    font-style: normal;
  }

  html {
    box-sizing: border-box;
    font-size: 100%;
  }

  body {
    margin: 0;
    background-color: ${color.lightGray};
    color: ${color.darkGray};
    font-family: ${font.nexa}, 'Helvetica', 'Arial', sans-serif;
    font-size: ${fontSize.default};
    font-weight: 300;
    letter-spacing: .01em;
    line-height: 1.6;
  }

  h2 {
    margin-top: 60px;
    font-size: 18px;
    line-height: 22px;
    margin-bottom: 20px;
  }

  p {
    margin: 0;
    padding: 0;
  }

  ul {
    margin: 0;
    padding: 0;
  }

  a {
    text-decoration: none;
  }

  p, a, div, span {
    color: ${color.darkGray};
  }

  input, textarea, select {
    appearance: none;
    font-family: ${font.nexa}, 'Helvetica', 'Arial', sans-serif;
    background-color: transparent;
    box-sizing: inherit;
    padding: 6px 10px;
    width: 100%;
    font-size: ${fontSize.default};
    line-height: 25px;
    margin: 0;
  }
  
  input[type=checkbox] {
    appearance: checkbox;
  }

  button {
    appearance: none;

    &:focus {
      outline: none;
    }
  }

  ::placeholder {
    color: ${color.darkGray};
    opacity: 0.5;
  }
`
/* eslint-enable */
