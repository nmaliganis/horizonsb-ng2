import 'babel-polyfill'

import React from 'react'
import ReactDOM from 'react-dom'
import createSageMiddleware from 'redux-saga'
import { createStore, applyMiddleware } from 'redux'

/* eslint-disable import/no-webpack-loader-syntax */
import '!file-loader?name=[name].[ext]!./static/images/favicon.png'
import '!file-loader?name=[name].[ext]!./static/images/no-image.png'
import '!file-loader?name=[name].[ext]!./static/manifest.json'
import '!file-loader?name=[name].[ext]!./static/robots.txt'
import '!file-loader?name=[name].[ext]!./static/fonts/RiftSoft-Bold.otf'
import '!file-loader?name=[name].[ext]!./static/fonts/Nexa-XBold.ttf'
import '!file-loader?name=[name].[ext]!./static/fonts/Nexa-Regular.ttf'
/* eslint-enable import/no-webpack-loader-syntax */

import clientStorage from 'services/clientStorage'
import App from 'containers/App'
import rootReducer from './reducers'
import saga from './sagas'

if (process.env.NODE_ENV === 'production') {
  require('offline-plugin/runtime').install() // eslint-disable-line global-require
}

const preloadedState = {
  auth: {
    authenticated: Boolean(clientStorage.getAccessToken()),
  },
}

const sagaMiddleware = createSageMiddleware()
const createStoreWithMiddleware = applyMiddleware(sagaMiddleware)(createStore)

const store = createStoreWithMiddleware(
  rootReducer,
  preloadedState,

  window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
)

sagaMiddleware.run(saga)

ReactDOM.render(<App store={store} />, document.getElementById('app'))
