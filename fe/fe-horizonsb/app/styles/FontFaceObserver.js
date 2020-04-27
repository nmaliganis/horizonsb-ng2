import FontFaceObserver from 'fontfaceobserver'
import { font } from './variables'

const riftSoft = new FontFaceObserver(font.riftSoft)
const nexa = new FontFaceObserver(font.nexa)

Promise.all([riftSoft.load(), nexa.load()]).then(
  () => {
    document.body.classList.add('fontLoaded')
  },
  () => {
    document.body.classList.remove('fontLoaded')
  }
)
