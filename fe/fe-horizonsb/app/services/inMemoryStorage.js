const cache = {}

const inMemoryStorage = {
  getItem(key) {
    return cache[key] || null
  },
  setItem(key, value) {
    cache[key] = value
  },
  removeItem(key) {
    delete cache[key]
  },
}

export default inMemoryStorage
