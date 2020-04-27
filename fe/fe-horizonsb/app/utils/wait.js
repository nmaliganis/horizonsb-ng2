const wait = (ms = 5000) => new Promise(r => setTimeout(r, ms))

export default wait
