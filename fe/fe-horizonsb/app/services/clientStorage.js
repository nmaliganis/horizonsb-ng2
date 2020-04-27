import inMemoryStorage from './inMemoryStorage'

const storageAvailable = type => {
  const storage = window[type]
  try {
    const testItem = '__storage_test__'
    storage.setItem(testItem, testItem)
    storage.removeItem(testItem)
    return true
  } catch (exception) {
    return (
      exception instanceof DOMException &&
      (exception.code === 22 ||
        exception.code === 1014 ||
        exception.name === 'QuotaExceededError' ||
        exception.name === 'NS_ERROR_DOM_QUOTA_REACHED') &&
      storage.length !== 0
    )
  }
}

const storage = storageAvailable('localStorage')
  ? localStorage
  : inMemoryStorage

export default {
  getAccessToken: () => storage.getItem('accessToken'),
  getRefreshToken: () => storage.getItem('refreshToken'),
  setTokens: (accessToken, refreshToken) => {
    storage.setItem('accessToken', accessToken)
    storage.setItem('refreshToken', refreshToken)
    storage.setItem('lastRefreshTimestamp', new Date().getTime())
  },
  removeTokens: () => {
    const refreshToken = storage.getItem('refreshToken')

    storage.removeItem('accessToken')
    storage.removeItem('refreshToken')
    storage.removeItem('lastRefreshTimestamp')

    return refreshToken
  },
  getLastRefreshTimestamp: () => storage.getItem('lastRefreshTimestamp'),
}
