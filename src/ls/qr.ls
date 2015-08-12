qr = module.exports = {}

qr.query = ->
  query = location.search.substring(1).split('&')
  params = {}
  for i of query
    key= query[i].split('=')[0]
    value = query[i].split('=')[1]
    params[key] = value
  params